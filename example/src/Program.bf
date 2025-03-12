using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using static libpng.libpng;

namespace example;

static class Program
{
	[CLink] public static extern FILE* fopen(char8* filename, char8* mode);
	[CLink] public static extern void* fclose(FILE* file);

	static int Main(params String[] args)
	{
		let fp = fopen("test.png", "rb");

		png_struct* png_ptr = png_create_read_struct((png_charp)PNG_LIBPNG_VER_STRING, null, null, null);
		png_info* info_ptr = png_create_info_struct(png_ptr); // <-- creating a new, local info_ptr
		png_init_io(png_ptr, fp);
		png_read_png(png_ptr, info_ptr, PNG_TRANSFORM_IDENTITY, null);
		let w = png_get_image_width(png_ptr, info_ptr);
		let h = png_get_image_height(png_ptr, info_ptr);
		png_destroy_read_struct(&png_ptr, &info_ptr, null); // <-- destroying the info_ptr (as well).
		fclose(fp);

		Debug.WriteLine($"width: {w} height: {h}");

		return 0;
	}
}