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

- **docker run -it python:3.9; docker run -it python:3.9 bash; docker run -it --entrypoint=bash python:3.9 三个命令的区别**

  - docker run -it python:3.9
    - 启动一个基于 python:3.9 镜像的 Docker 容器，并进入 Python 交互式环境，在容器内直接使用 Python 环境进行交互式编程。
  
  - docker run -it python:3.9 bash
    - 容器启动后，会直接进入 bash 命令行界面，而不是 Python 环境；在 bash 环境中，你可以运行操作系统级命令（如安装包、查看文件等）。
  
  - docker run -it --entrypoint=bash python:3.9
    - 这个命令与第二个命令功能相似，但显式地修改了容器的 entrypoint，将其设置为 bash，而不是镜像默认的 python 命令。--entrypoint=bash 参数会覆盖容器默认的入口点（通常是服务启动脚本）。这意味着容器启动后并不会执行容器中预设的服务启动流程，而是进入 Bash shell。这可能导致服务没有启动，或者其他本该执行的自动化流程（例如应用程序初始化、网络设置等）被跳过。另一方面，docker run -it python:3.9 bash 会启动一个交互式 Bash shell，但不会改变容器的默认启动行为。如果你只是通过这种方式进入容器，生产流程（如服务的启动）不会受到影响，因为容器本身会按照预设的 ENTRYPOINT 或 CMD 指令来启动。

- **容器启动postgreSQL后，只能在容器内登录至数据库，而无法在容器外访问数据库，且收到“角色“root”不存在”的报错**
  - 这意味着您已经在本地安装了 postgres。Winkey + R 输入 services.msc 根据安装的版本搜索 Postgres 服务。单击停止。
  - **退出PostgreSQL服务**
    - 在 PostgreSQL 命令行使用 \q 退出。
    - 如果想停止容器，可以使用docker ps查看<container_id_or_name>然后 docker stop <container_id_or_name>。
    - 在交互式终端中可以使用 Ctrl + C 来中断。
  
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

- **端口匹配的讲究**
  - 标准端口： 很多服务或协议有指定的标准端口。例如：

    HTTP：80
    
    HTTPS：443
    
    PostgreSQL：5432

    MySQL：3306
    
    FTP：21
    
    SSH：22

    pgAdmin 是 PostgreSQL 数据库的图形用户界面管理工具，通常用于数据库的配置、管理和查询执行。在默认情况下，pgAdmin 使用端口 8080，避免与其他已在 80 端口上运行的服务冲突。端口 8080 是常见的 HTTP Web 服务的备用端口。

    

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
