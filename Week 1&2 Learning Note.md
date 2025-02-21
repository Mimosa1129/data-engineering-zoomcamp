# Data Engineering Zoomcamp Learning Note

## Learning Path for Data Engineer

### Local Deployment
- **使用 Docker 容器化应用**
- **功能**：构建容器化的应用，确保跨环境一致性，便于在本地模拟云端环境，构建和部署应用。配置 Dockerfile 来构建和部署数据处理应用。
- Download：[Docker](https://www.docker.com/get-started)

### ------Optional------
#### **Git**
- **功能**：版本控制工具，用于管理代码历史和团队协作。
- Download：[Git for Windows](https://git-scm.com/downloads)
#### **Python**
- **功能**：用于编写和执行数据处理脚本，`pip` 用于安装外部库。
- Download：[Python](https://www.python.org/downloads/)
#### **数据库（如 MySQL 或 PostgreSQL）**
- **功能**：存储和管理结构化数据，支持数据查询。
- Download：[MySQL](https://www.mysql.com/downloads/) 或 [PostgreSQL](https://www.postgresql.org/download/)
#### **数据管道和任务调度：**
- **使用 Airflow 构建数据管道**
- **功能**：任务调度和工作流管理
  - 工作流（Workflow）：Airflow 通过定义任务之间的依赖关系来创建工作流，确保任务按照正确的顺序执行。
  - 调度（Scheduling）：任务可以根据时间间隔进行调度执行，支持 Cron 表达式等多种调度方式。
- Download: [Airflow](https://airflow.apache.org/docs/apache-airflow/stable/index.html)

### Cloud Platform Deployment
- 使用 Docker 来部署和管理应用。
- 使用云服务（AWS、[GCP](https://console.cloud.google.com/)）进行应用托管。

## Questions during module 1
- **什么是 Ubuntu？**
  - Ubuntu 是一种基于 Linux 内核 的开源操作系统，它以简单、易用和高性能著称，广泛用于服务器、个人电脑和云计算环境中。

- **什么是 Docker？**

  - Docker 是一个开源的容器化平台，它可以让开发者：
  - 封装应用：将应用程序及其所有依赖项打包到一个轻量级的容器中。
  - 独立运行：容器可以在任何支持 Docker 的环境中运行（例如本地、云服务器）。
  - 提高效率：相比虚拟机，容器启动更快，占用资源更少。

- **如何下载ny_taxi的csv数据**
  - csv数据备份地址 https://github.com/DataTalksClub/nyc-tlc-data

```python
import os
import requests
from datetime import datetime
from dateutil.relativedelta import relativedelta

# 设置保存路径
download_folder = r"D:\Learning Document\DEEEEEEEEEEEEEEEEEE\DE Zoomcamp"

# 定义起始时间
start_date = datetime(2019, 1, 1)
end_date = datetime(2021, 7, 1)

# 构建每个月三个不同的 URL 模式
while start_date <= end_date:
    # 格式化为 YYYY-MM 格式
    file_name = start_date.strftime('%Y-%m')
    
    # 构建下载链接
    yellow_url = f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_{file_name}.csv.gz"
    green_url = f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_{file_name}.csv.gz"
    fhv_url = f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/fhv/fhv_tripdata_{file_name}.csv.gz"
    
    # 文件路径
    yellow_file_path = os.path.join(download_folder, f"yellow_tripdata_{file_name}.csv.gz")
    green_file_path = os.path.join(download_folder, f"green_tripdata_{file_name}.csv.gz")
    fhv_file_path = os.path.join(download_folder, f"fhv_tripdata_{file_name}.csv.gz")
    
    # 下载黄色文件
    if not os.path.exists(yellow_file_path):
        try:
            print(f"正在下载黄色数据：{yellow_url} ...")
            response = requests.get(yellow_url)
            if response.status_code == 200:
                with open(yellow_file_path, "wb") as file:
                    file.write(response.content)
                print(f"黄色数据 {file_name} 下载完成")
            else:
                print(f"黄色数据 {file_name} 文件不存在")
        except Exception as e:
            print(f"下载失败: 黄色数据 {file_name}, 错误: {e}")
    else:
        print(f"黄色数据 {file_name} 已存在，跳过下载")
    
    # 下载绿色文件
    if not os.path.exists(green_file_path):
        try:
            print(f"正在下载绿色数据：{green_url} ...")
            response = requests.get(green_url)
            if response.status_code == 200:
                with open(green_file_path, "wb") as file:
                    file.write(response.content)
                print(f"绿色数据 {file_name} 下载完成")
            else:
                print(f"绿色数据 {file_name} 文件不存在")
        except Exception as e:
            print(f"下载失败: 绿色数据 {file_name}, 错误: {e}")
    else:
        print(f"绿色数据 {file_name} 已存在，跳过下载")
    
    # 下载 FHV 文件
    if not os.path.exists(fhv_file_path):
        try:
            print(f"正在下载 FHV 数据：{fhv_url} ...")
            response = requests.get(fhv_url)
            if response.status_code == 200:
                with open(fhv_file_path, "wb") as file:
                    file.write(response.content)
                print(f"FHV 数据 {file_name} 下载完成")
            else:
                print(f"FHV 数据 {file_name} 文件不存在")
        except Exception as e:
            print(f"下载失败: FHV 数据 {file_name}, 错误: {e}")
    else:
        print(f"FHV 数据 {file_name} 已存在，跳过下载")
    
    # 将日期加一个月
    start_date += relativedelta(months=1)
```

- **如何将有大量数据的csv表写入数据库中**
  - 对于数据量非常大的情况，先读取几行数据来生成 schema 并使用分批处理（chunking）将数据写入 PostgreSQL 是一种更高效的方式。这样可以避免一次性加载所有数据到内存中，从而减少内存占用。

```python
df_schema.head(n=0).to_sql(name=tablename, con=postgres_engine, if_exists='replace', index=False)

chunksize = 100000
for chunk in pd.read_csv(filename, chunksize = chunksize):
    time_start = time()
    chunk.tpep_pickup_datetime = pd.to_datetime(chunk.tpep_pickup_datetime)
    chunk.tpep_dropoff_datetime = pd.to_datetime(chunk.tpep_dropoff_datetime)
    chunk.to_sql(tablename, postgres_engine, if_exists='append', index=False)
    time_end = time()
    print(f"Inserted chunk with {len(chunk)} rows, took {time_end - time_start:.3f} seconds. ")
```



## Data Engineering Zoomcamp Information


<p align="center">
  <a href="https://airtable.com/shr6oVXeQvSI5HuWD"><img src="https://user-images.githubusercontent.com/875246/185755203-17945fd1-6b64-46f2-8377-1011dcb1a444.png" height="50" /></a>
</p>

- Register in [DataTalks.Club's Slack](https://datatalks.club/slack.html)
- Join the [`#course-data-engineering`](https://app.slack.com/client/T01ATQK62F8/C01FABYF2RG) channel
- Join the [course Telegram channel with announcements](https://t.me/dezoomcamp)
- The videos are published on [DataTalks.Club's YouTube channel](https://www.youtube.com/c/DataTalksClub) in [the course playlist](https://www.youtube.com/playlist?list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
- [Frequently asked technical questions](https://docs.google.com/document/d/19bnYs80DwuUimHM65UV3sylsCn2j1vziPOwzBwQrebw/edit?usp=sharing)

Syllabus

* [Module 1: Containerization and Infrastructure as Code](#module-1-containerization-and-infrastructure-as-code)
* [Module 2: Workflow Orchestration](#module-2-workflow-orchestration)
* [Workshop 1: Data Ingestion](#workshop-1-data-ingestion)
* [Module 3: Data Warehouse](#module-3-data-warehouse)
* [Module 4: Analytics Engineering](#module-4-analytics-engineering)
* [Module 5: Batch processing](#module-5-batch-processing)
* [Module 6: Streaming](#module-6-streaming)
* [Project](#project)
