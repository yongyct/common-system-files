'''
Sample template for multiprocessing
'''
import multiprocessing as mp

def my_func(my_args):
    print(my_args)

# Set number of jobs based on percentage of cpu available
n_jobs = mp.cpu_count // 2
pool = mp.Pool(n_jobs)

# E.g. iterable batch of data to be processed
all_my_data = [i for i in range(1000)]

try:
    tasks = [pool.apply_async(my_func, (my_data, )) for my_data in all_my_data]
    for task in tasks:
        task.get()
    pool.close()
    pool.join()
except KeyboardInterrupt:
    pool.close()
    pool.terminate()
