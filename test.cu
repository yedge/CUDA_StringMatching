#include <stdio.h>

__global__
void test(char* a, int* b)
{
	a[threadIdx.x] += b[threadIdx.x];
}

int main()
{
	int 	dec[7] = {1, 1, 1, 1, 1, 1, 0};
	char 	str[7] = "Hello ";
	
	printf("%s", str);

	int* 	cuda_mem_int;
	char* 	cuda_mem_str;

	cudaMalloc((void**)&cuda_mem_str, sizeof(str));
	cudaMalloc((void**)&cuda_mem_int, sizeof(dec));

	cudaMemcpy(cuda_mem_str, str, sizeof(str), cudaMemcpyHostToDevice);
	cudaMemcpy(cuda_mem_int, dec, sizeof(dec), cudaMemcpyHostToDevice);

	dim3 dimBlock(7);
	dim3 dimGrid(1);

	test<<<dimGrid, dimBlock>>>(cuda_mem_str, cuda_mem_int);

	cudaMemcpy(str, cuda_mem_str, sizeof(str), cudaMemcpyDeviceToHost);

	cudaFree(cuda_mem_str);

	printf("%s\n", str);

	return 1;
}
