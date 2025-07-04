USE [master]
GO
/****** Object:  Database [數據分析職缺_專題]    Script Date: 2025/7/4 下午 03:02:14 ******/
CREATE DATABASE [數據分析職缺_專題]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'104職缺', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\104職缺.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'104職缺_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\104職缺_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [數據分析職缺_專題] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [數據分析職缺_專題].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [數據分析職缺_專題] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET ARITHABORT OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [數據分析職缺_專題] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [數據分析職缺_專題] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET  DISABLE_BROKER 
GO
ALTER DATABASE [數據分析職缺_專題] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [數據分析職缺_專題] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [數據分析職缺_專題] SET  MULTI_USER 
GO
ALTER DATABASE [數據分析職缺_專題] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [數據分析職缺_專題] SET DB_CHAINING OFF 
GO
ALTER DATABASE [數據分析職缺_專題] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [數據分析職缺_專題] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [數據分析職缺_專題] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [數據分析職缺_專題] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [數據分析職缺_專題] SET QUERY_STORE = ON
GO
ALTER DATABASE [數據分析職缺_專題] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [數據分析職缺_專題]
GO
/****** Object:  Table [dbo].[jobs_104_cleaned]    Script Date: 2025/7/4 下午 03:02:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobs_104_cleaned](
	[jobNo] [bigint] NULL,
	[jobName] [varchar](max) NULL,
	[custName] [varchar](max) NULL,
	[location] [varchar](max) NULL,
	[education] [varchar](max) NULL,
	[experience] [varchar](max) NULL,
	[salaryLow] [bigint] NULL,
	[salaryHigh] [bigint] NULL,
	[salaryDesc] [varchar](max) NULL,
	[appearDate] [bigint] NULL,
	[job_category] [varchar](max) NULL,
	[industry] [varchar](max) NULL,
	[description] [varchar](max) NULL,
	[lon] [float] NULL,
	[lat] [float] NULL,
	[mrt] [float] NULL,
	[dist] [float] NULL,
	[isActivelyHiring] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobs_104_raw]    Script Date: 2025/7/4 下午 03:02:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobs_104_raw](
	[jobType] [bigint] NULL,
	[jobNo] [bigint] NULL,
	[jobName] [varchar](max) NULL,
	[jobNameSnippet] [varchar](max) NULL,
	[jobRole] [bigint] NULL,
	[jobRo] [bigint] NULL,
	[jobAddrNo] [bigint] NULL,
	[jobAddrNoDesc] [varchar](max) NULL,
	[jobAddress] [varchar](max) NULL,
	[description] [varchar](max) NULL,
	[descWithoutHighlight] [varchar](max) NULL,
	[optionEdu] [varchar](max) NULL,
	[period] [bigint] NULL,
	[periodDesc] [varchar](max) NULL,
	[applyCnt] [bigint] NULL,
	[applyType] [bigint] NULL,
	[applyDesc] [varchar](max) NULL,
	[custNo] [bigint] NULL,
	[custName] [varchar](max) NULL,
	[coIndustry] [bigint] NULL,
	[coIndustryDesc] [varchar](max) NULL,
	[salaryLow] [bigint] NULL,
	[salaryHigh] [bigint] NULL,
	[salaryDesc] [varchar](max) NULL,
	[s10] [bigint] NULL,
	[appearDate] [bigint] NULL,
	[appearDateDesc] [varchar](max) NULL,
	[optionZone] [bigint] NULL,
	[isApply] [bigint] NULL,
	[applyDate] [float] NULL,
	[userApplyCount] [bigint] NULL,
	[isSave] [bigint] NULL,
	[descSnippet] [varchar](max) NULL,
	[tags] [varchar](max) NULL,
	[landmark] [varchar](max) NULL,
	[link] [varchar](max) NULL,
	[jobsource] [varchar](max) NULL,
	[jobNameRaw] [varchar](max) NULL,
	[custNameRaw] [varchar](max) NULL,
	[lon] [float] NULL,
	[lat] [float] NULL,
	[remoteWorkType] [bigint] NULL,
	[major] [varchar](max) NULL,
	[salaryType] [varchar](max) NULL,
	[dist] [float] NULL,
	[mrt] [float] NULL,
	[mrtDesc] [varchar](max) NULL,
	[isActivelyHiring] [bit] NULL,
	[爬蟲日期] [varchar](max) NULL,
	[job_category] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobsdb_jobs]    Script Date: 2025/7/4 下午 03:02:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobsdb_jobs](
	[id] [bigint] NULL,
	[title] [varchar](max) NULL,
	[companyName] [varchar](max) NULL,
	[listingDate] [varchar](max) NULL,
	[locations] [varchar](max) NULL,
	[salaryLabel] [varchar](max) NULL,
	[teaser] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [數據分析職缺_專題] SET  READ_WRITE 
GO
