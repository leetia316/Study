#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void rle(char *filename, char *outfile)
{ //压缩函数
  FILE *in, *out;
  int filelen;
  char cur, tmp;
  if (!(in = fopen(filename, "rb"))) //以二进制方式打开只读文件（原文件必须存在）
    printf("文件打开失败\n");        //若文件不存在则进行提示
  else
  {
    out = fopen(outfile, "wb"); //二进制方式打开只写文件（若文件不存在则会进行创建，若存在则会覆盖原内容)
    cur = fgetc(in);            //读取一个字符，返回读取到的字符，当读到文件末尾则返回EOF
    tmp = cur;
    filelen = 1;
    while (!feof(in))
    {
      cur = fgetc(in);
      if (cur == tmp)
      {
        filelen++;
      } //进行RLE压缩
      else
      {
        fputc(filelen + '0', out); //写一个字符（此处是计数数字），若失败则返回EOF
        fputc(tmp, out);           //同上，此处是原字符
        tmp = cur;
        filelen = 1;
      }
    }
  }
  fclose(in);
  fclose(out); //关闭文件
}

void unRle(char *filename, char *outfile)
{ // 解压函数
  FILE *in, *out;
  int filelen;
  char cur;
  if (!(in = fopen(filename, "rb")))
    printf("文件打开失败\n");
  else
  {
    out = fopen(outfile, "wb");
    while (!feof(in))
    {
      filelen = fgetc(in) - '0';
      if (feof(in))
        break;
      cur = fgetc(in);
      while (filelen--)
        fputc(cur, out);
    }
  }
  fclose(in);
  fclose(out);
}

int main(int argc, char *argv[])
{ //通过判断命令行参数进行相应操作
  if (!strcmp(argv[2], "-d"))
  {
    unRle(argv[1], argv[3]);
    printf("decompress finished\n");
  }
  else if (!strcmp(argv[2], "-c"))
  {
    rle(argv[1], argv[3]);
    printf("compress finished\n");
  }
  else
    printf("输入参数有误,请重新检查,-c : compress; -d : decompress\n");
  return 0;
}