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
		png_bytep* row_pointers = null;

		let fp = fopen("test.png", "rb");

		png_struct* readpng = png_create_read_struct((png_charp)PNG_LIBPNG_VER_STRING, null, null, null);
		png_info* readinfo = png_create_info_struct(readpng); // <-- creating a new, local info_ptr
		png_init_io(readpng, fp);
		png_read_info(readpng, readinfo);
		//png_read_png(readpng, readinfo, PNG_TRANSFORM_IDENTITY, null);
		let w = png_get_image_width(readpng, readinfo);
		let h = png_get_image_height(readpng, readinfo);

		row_pointers = (png_bytep*)Internal.StdMalloc(sizeof(png_bytep) * h);
		for (let y < h)
		{
			row_pointers[y] = (png_byte*)Internal.StdMalloc((.)png_get_rowbytes(readpng, readinfo));
		}

		png_read_image(readpng, row_pointers);

		png_destroy_read_struct(&readpng, &readinfo, null); // <-- destroying the info_ptr (as well).

		fclose(fp);

		let writefp = fopen("write_copy.png", "wb");
		png_struct* writepng = png_create_write_struct((png_charp)PNG_LIBPNG_VER_STRING, null, null, null);
		png_info* writeinfo = png_create_info_struct(writepng);
		png_set_IHDR(writepng, writeinfo, w, h, 8, PNG_COLOR_TYPE_RGBA, PNG_INTERLACE_NONE, PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

		png_init_io(writepng, writefp);
		png_write_info(writepng, writeinfo);
		png_write_image(writepng, row_pointers);
		png_write_end(writepng, null);
		png_destroy_write_struct(&writepng, &writeinfo);

		for (let y < h)
		{
			Internal.StdFree(row_pointers[y]);
		}
		Internal.StdFree(row_pointers);


		fclose(writefp);

		Debug.WriteLine($"width: {w} height: {h}");

		return 0;
	}
}