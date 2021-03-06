USE [master]
GO
/****** Object:  Database [hackathon-health-db]    Script Date: 11/19/2018 12:32:31 PM ******/
CREATE DATABASE [hackathon-health-db]
GO
ALTER DATABASE [hackathon-health-db] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [hackathon-health-db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [hackathon-health-db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [hackathon-health-db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [hackathon-health-db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [hackathon-health-db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [hackathon-health-db] SET ARITHABORT OFF 
GO
ALTER DATABASE [hackathon-health-db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [hackathon-health-db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [hackathon-health-db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [hackathon-health-db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [hackathon-health-db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [hackathon-health-db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [hackathon-health-db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [hackathon-health-db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [hackathon-health-db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [hackathon-health-db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [hackathon-health-db] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [hackathon-health-db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [hackathon-health-db] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [hackathon-health-db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [hackathon-health-db] SET  MULTI_USER 
GO
ALTER DATABASE [hackathon-health-db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [hackathon-health-db] SET ENCRYPTION ON
GO
ALTER DATABASE [hackathon-health-db] SET QUERY_STORE = ON
GO
ALTER DATABASE [hackathon-health-db] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [hackathon-health-db]
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
USE [hackathon-health-db]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 11/19/2018 12:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [bigint] IDENTITY(1,1) NOT NULL,
	[PublicKey] [varchar](500) NOT NULL,
	[QRCode] [varchar](500) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Physician]    Script Date: 11/19/2018 12:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Physician](
	[PhysicianID] [bigint] IDENTITY(1,1) NOT NULL,
	[PublicKey] [varchar](500) NOT NULL,
	[QRCode] [varchar](500) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionDetail]    Script Date: 11/19/2018 12:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionDetail](
	[TransactionDetailID] [bigint] IDENTITY(1,1) NOT NULL,
	[TransactionHeaderID] [bigint] NOT NULL,
	[ChargeType] [varchar](50) NOT NULL,
	[ChargeValue] [decimal](18, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionHeader]    Script Date: 11/19/2018 12:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionHeader](
	[TransactionHeaderID] [bigint] IDENTITY(1,1) NOT NULL,
	[PhysicianKey] [varchar](500) NULL,
	[PatientKey] [varchar](500) NULL,
	[TimeElapsed] [int] NULL,
	[TransactionDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TransactionHeader] ADD  CONSTRAINT [DF_TransactionHeader_TimeElapsed]  DEFAULT ((0)) FOR [TimeElapsed]
GO
USE [master]
GO
ALTER DATABASE [hackathon-health-db] SET  READ_WRITE 
GO

--Sample data insert
/*
INSERT INTO [dbo].[Patient]
           ([PublicKey]
           ,[QRCode])
     VALUES
           ('0xBEDa8BE440d4afae4c4E28469fABd24a20e1b747',
           ,'0xBEDa8BE440d4afae4c4E28469fABd24a20e1b747')
GO


INSERT INTO [dbo].[Physician]
           ([PublicKey]
           ,[QRCode])
     VALUES
           ('0x66E437D3FB414Ca912678c7Ef49C7EDB6347cfdD'
           ,'0x66E437D3FB414Ca912678c7Ef49C7EDB6347cfdD')
GO

*/



