/* vi: set sw=4 ts=4: */
/*
 *  busybox patch applet to handle the unified diff format.
 *  Copyright (C) 2003 Glenn McGrath
 *
 *  Licensed under the GPL v2 or later, see the file LICENSE in this tarball.
 *
 *  This applet is written to work with patches generated by GNU diff,
 *  where there is equivalent functionality busybox patch shall behave
 *  as per GNU patch.
 *
 *  There is a SUSv3 specification for patch, however it looks to be
 *  incomplete, it doesnt even mention unified diff format.
 *  http://www.opengroup.org/onlinepubs/007904975/utilities/patch.html
 *
 *  Issues
 *   - Non-interactive
 *   - Patches must apply cleanly or patch (not just one hunk) will fail.
 *   - Reject file isnt saved
 */

#include "libbb.h"

static unsigned copy_lines(FILE *src_stream, FILE *dst_stream, unsigned lines_count)
{
	while (src_stream && lines_count) {
		char *line;
		line = xmalloc_fgets(src_stream);
		if (line == NULL) {
			break;
		}
		if (fputs(line, dst_stream) == EOF) {
			bb_perror_msg_and_die("error writing to new file");
		}
		free(line);
		lines_count--;
	}
	return lines_count;
}

/* If patch_level is -1 it will remove all directory names
 * char *line must be greater than 4 chars
 * returns NULL if the file doesnt exist or error
 * returns malloc'ed filename
 * NB: frees 1st argument!
 */
static char *extract_filename(char *line, int patch_level, const char *pat)
{
	char *temp = NULL, *filename_start_ptr = line + 4;

	if (strncmp(line, pat, 4) == 0) {
		/* Terminate string at end of source filename */
		line[strcspn(line, "\t\n\r")] = '\0';

		/* Skip over (patch_level) number of leading directories */
		while (patch_level--) {
			temp = strchr(filename_start_ptr, '/');
			if (!temp)
				break;
			filename_start_ptr = temp + 1;
		}
		temp = xstrdup(filename_start_ptr);
	}
	free(line);
	return temp;
}

int patch_main(int argc, char **argv) MAIN_EXTERNALLY_VISIBLE;
int patch_main(int argc UNUSED_PARAM, char **argv)
{
	struct stat saved_stat;
	char *patch_line;
	FILE *patch_file;
	int patch_level;
	int ret = 0;
	char plus = '+';

	xfunc_error_retval = 2;
	{
		const char *p = "-1";
		const char *i = "-"; /* compat */
		if (getopt32(argv, "p:i:R", &p, &i) & 4)
			plus = '-';
		patch_level = xatoi(p); /* can be negative! */
		patch_file = xfopen_stdin(i);
	}

	patch_line = xmalloc_fgetline(patch_file);
	while (patch_line) {
		FILE *src_stream;
		FILE *dst_stream;
		//char *old_filename;
		char *new_filename;
		char *backup_filename;
		unsigned src_cur_line = 1;
		unsigned dst_cur_line = 0;
		unsigned dst_beg_line;
		unsigned bad_hunk_count = 0;
		unsigned hunk_count = 0;
		smallint copy_trailing_lines_flag = 0;

		/* Skip everything upto the "---" marker
		 * No need to parse the lines "Only in <dir>", and "diff <args>"
		 */
		do {
			/* Extract the filename used before the patch was generated */
			new_filename = extract_filename(patch_line, patch_level, "--- ");
			// was old_filename above
			patch_line = xmalloc_fgetline(patch_file);
			if (!patch_line) goto quit;
		} while (!new_filename);
		free(new_filename); // "source" filename is irrelevant

		new_filename = extract_filename(patch_line, patch_level, "+++ ");
		if (!new_filename) {
			bb_error_msg_and_die("invalid patch");
		}

		/* Get access rights from the file to be patched */
		if (stat(new_filename, &saved_stat) != 0) {
			char *slash = strrchr(new_filename, '/');
			if (slash) {
				/* Create leading directories */
				*slash = '\0';
				bb_make_directory(new_filename, -1, FILEUTILS_RECUR);
				*slash = '/';
			}
			backup_filename = NULL;
			src_stream = NULL;
			saved_stat.st_mode = 0644;
		} else {
			backup_filename = xasprintf("%s.orig", new_filename);
			xrename(new_filename, backup_filename);
			src_stream = xfopen_for_read(backup_filename);
		}
		dst_stream = xfopen_for_write(new_filename);
		fchmod(fileno(dst_stream), saved_stat.st_mode);

		printf("patching file %s\n", new_filename);

		/* Handle all hunks for this file */
		patch_line = xmalloc_fgets(patch_file);
		while (patch_line) {
			unsigned count;
			unsigned src_beg_line;
			unsigned hunk_offset_start;
			unsigned src_last_line = 1;
			unsigned dst_last_line = 1;

			if ((sscanf(patch_line, "@@ -%d,%d +%d,%d", &src_beg_line, &src_last_line, &dst_beg_line, &dst_last_line) < 3)
			 && (sscanf(patch_line, "@@ -%d +%d,%d", &src_beg_line, &dst_beg_line, &dst_last_line) < 2)
			) {
				/* No more hunks for this file */
				break;
			}
			if (plus != '+') {
				/* reverse patch */
				unsigned tmp = src_last_line;
				src_last_line = dst_last_line;
				dst_last_line = tmp;
				tmp = src_beg_line;
				src_beg_line = dst_beg_line;
				dst_beg_line = tmp;
			}
			hunk_count++;

			if (src_beg_line && dst_beg_line) {
				/* Copy unmodified lines upto start of hunk */
				/* src_beg_line will be 0 if it's a new file */
				count = src_beg_line - src_cur_line;
				if (copy_lines(src_stream, dst_stream, count)) {
					bb_error_msg_and_die("bad src file");
				}
				src_cur_line += count;
				dst_cur_line += count;
				copy_trailing_lines_flag = 1;
			}
			src_last_line += hunk_offset_start = src_cur_line;
			dst_last_line += dst_cur_line;

			while (1) {
				free(patch_line);
				patch_line = xmalloc_fgets(patch_file);
				if (patch_line == NULL)
					break; /* EOF */
				if ((*patch_line != '-') && (*patch_line != '+')
				 && (*patch_line != ' ')
				) {
					break; /* End of hunk */
				}
				if (*patch_line != plus) { /* '-' or ' ' */
					char *src_line = NULL;
					if (src_cur_line == src_last_line)
						break;
					if (src_stream) {
						src_line = xmalloc_fgets(src_stream);
						if (src_line) {
							int diff = strcmp(src_line, patch_line + 1);
							src_cur_line++;
							free(src_line);
							if (diff)
								src_line = NULL;
						}
					}
					if (!src_line) {
						bb_error_msg("hunk #%u FAILED at %u", hunk_count, hunk_offset_start);
						bad_hunk_count++;
						break;
					}
					if (*patch_line != ' ') { /* '-' */
						continue;
					}
				}
				if (dst_cur_line == dst_last_line)
					break;
				fputs(patch_line + 1, dst_stream);
				dst_cur_line++;
			} /* end of while loop handling one hunk */
		} /* end of while loop handling one file */

		/* Cleanup last patched file */
		if (copy_trailing_lines_flag) {
			copy_lines(src_stream, dst_stream, (unsigned)(-1));
		}
		if (src_stream) {
			fclose(src_stream);
		}
		fclose(dst_stream);
		if (bad_hunk_count) {
			ret = 1;
			bb_error_msg("%u out of %u hunk FAILED", bad_hunk_count, hunk_count);
		} else {
			/* It worked, we can remove the backup */
			if (backup_filename) {
				unlink(backup_filename);
			}
			if ((dst_cur_line == 0) || (dst_beg_line == 0)) {
				/* The new patched file is empty, remove it */
				xunlink(new_filename);
				// /* old_filename and new_filename may be the same file */
				// unlink(old_filename);
			}
		}
		free(backup_filename);
		//free(old_filename);
		free(new_filename);
	} /* end of "while there are patch lines" */
 quit:
	/* 0 = SUCCESS
	 * 1 = Some hunks failed
	 * 2 = More serious problems (exited earlier)
	 */
	return ret;
}
