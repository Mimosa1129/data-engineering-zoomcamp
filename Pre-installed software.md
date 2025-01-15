# Data Engineering Zoomcamp Learning Note

## Learning Path for Data Engineer

### Local Deployment

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
- **使用 Docker 容器化应用**
- **功能**：构建容器化的应用，确保跨环境一致性，便于在本地模拟云端环境，构建和部署应用。配置 Dockerfile 来构建和部署数据处理应用。
- Download：[Docker](https://www.docker.com/get-started)

#### **Git**
- **功能**：版本控制工具，用于管理代码历史和团队协作。
- Download：[Git for Windows](https://git-scm.com/downloads)

### Cloud Platform Deployment
- 使用 Docker 来部署和管理应用。
- 使用云服务（AWS、[GCP](https://console.cloud.google.com/)）进行应用托管。

## Questions during module 1
- 什么是 Ubuntu？

  Ubuntu 是一种基于 Linux 内核 的开源操作系统，它以简单、易用和高性能著称，广泛用于服务器、个人电脑和云计算环境中。

- 什么是 Docker？

  Docker 是一个开源的容器化平台，它可以让开发者：
  封装应用：将应用程序及其所有依赖项打包到一个轻量级的容器中。
  独立运行：容器可以在任何支持 Docker 的环境中运行（例如本地、云服务器）。
  提高效率：相比虚拟机，容器启动更快，占用资源更少。





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
