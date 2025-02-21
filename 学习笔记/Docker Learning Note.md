# Docker
- **使用 Docker 容器化应用**
- **功能**：构建容器化的应用，确保跨环境一致性，便于在本地模拟云端环境，构建和部署应用。配置 Dockerfile 来构建和部署数据处理应用。容器可以在任何支持 Docker 的环境中运行（例如本地、云服务器）。相比虚拟机，容器启动更快，占用资源更少。
- Download：[Docker](https://www.docker.com/get-started)

- **在使用Docker时对本地资源的占用情况**
  - 镜像的磁盘空间占用：永久占用。Docker 镜像本身是下载并存储在本地磁盘中的，除非你手动删除它，否则它会一直占用磁盘空间。即使你停止或删除容器，镜像本身仍然会保留在本地，直到你执行 docker rmi <镜像名> 来删除它。
  - 容器的资源占用：临时占用。当你启动一个容器时，它会占用 CPU、内存、网络等资源。但一旦容器停止运行，Docker 会释放这些资源。如果你完全删除容器（使用 docker rm <容器名>），容器的文件系统和运行时资源也会被清理，释放掉这些占用的资源。
  - 数据卷（volumes）的占用：永久占用（除非手动删除）。如果你使用了数据卷来存储容器的数据，那么这些数据卷会在容器停止后依然存在，并且占用本地磁盘空间。你需要手动删除这些数据卷（使用 docker volume rm <卷名>），否则它们会一直占用磁盘空间。
 
- **docker可以拉取的东西：**
通过 [Docker Hub](https://hub.docker.com/)来查找和浏览镜像，或者直接使用 docker search <镜像名> 来查找感兴趣的镜像。
  - 操作系统：Ubuntu、Alpine Linux、CentOS 等常见操作系统镜像，可以用作基础镜像，进一步在其上安装应用程序和服务。示例：docker pull ubuntu，docker pull alpine。
  - 编程语言环境：Python、Node.js、Java、Ruby、Go、PHP 等。示例：docker pull python，docker pull node，docker pull openjdk。。
  - 数据库：MySQL、PostgreSQL、MongoDB、Redis、MariaDB、Elasticsearch 等。示例：docker pull mysql，docker pull postgres，docker pull redis。
  - Web 服务器和框架：Nginx、Apache HTTP Server、Tomcat、Flask、Django 等。示例：docker pull nginx，docker pull httpd，docker pull tomcat。
  - 开发工具和框架：Jenkins、GitLab、SonarQube 等 CI/CD 工具。TensorFlow、PyTorch、OpenCV 等用于机器学习和数据科学的镜像。示例：docker pull jenkins，docker pull tensorflow/tensorflow。
  - 应用程序：WordPress、Magento 等内容管理系统。Redmine、Jira 等项目管理工具。示例：docker pull wordpress，docker pull redmine。
  - 开发环境：VS Code Server、Jupyter Notebook、RStudio 等。示例：docker pull codercom/code-server，docker pull jupyter/base-notebook。
 
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

- **端口匹配的讲究**
  - 标准端口： 很多服务或协议有指定的标准端口。例如：

    HTTP：80
    
    HTTPS：443
    
    PostgreSQL：5432

    MySQL：3306
    
    FTP：21
    
    SSH：22

    pgAdmin 是 PostgreSQL 数据库的图形用户界面管理工具，通常用于数据库的配置、管理和查询执行。在默认情况下，pgAdmin 使用端口 8080，避免与其他已在 80 端口上运行的服务冲突。端口 8080 是常见的 HTTP Web 服务的备用端口。

- **使用 Docker Compose**
  - 如果你需要运行多个容器（例如一个包含 Web 服务器、数据库和缓存的应用），你可以使用 Docker Compose 来管理它们。需要创建一个 docker-compose.yml 文件来定义各个服务。
  - 启动所有服务 docker-compose up
  - 在后台运行 docker-compose up -d
  - 停止所有服务 docker-compose down
