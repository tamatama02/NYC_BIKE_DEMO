# Big Data Journey Lab2 : データレイク環境の基本的な操作

## コンテンツ

- Zeppelin Notebookの基本的な操作
- ワークショップで取り扱うデータセット（Citi Bike New York Cityデータ）の確認
- データレイク環境（Object Storage）へのデータのロード
- データレイク環境（Object Storage）のデータの操作

### Zeppelin Notebookの基本的な操作

ここでは、Zeppelin Notebookの基本的な以下の操作について確認します。

- Zeppelin Notebookの概要
  Zepplinは、WebベースのNotebookで、インタラクティブなデータ分析で用いられます。
  主な特徴は、多くの言語（Bash、Spark、JDBC（SQL）等）を一つのインターフェースとして統合して開発、管理できます。また、SQL結果の自動グラフ表示やAngular等、Data Visualizationを実現することも可能です。
  詳細は以下のURLの内容を参照ください。

  https://zeppelin.apache.org/

- Interpreterの設定
  Interpreterを設定することで、各パラグラフから任意のInterpreterを実行できるようになります。

![](https://camo.githubusercontent.com/5bed66e072e09d3e70b6012759eb29be9ce56cd7/68747470733a2f2f7777772e657665726e6f74652e636f6d2f73686172642f7336322f73682f30653634653537392d316563362d346365612d616661372d3136313534616663363761322f376164366131643833386432363339322f7265732f38396437366638322d656462382d343063642d623362622d6537346638626566313330382f736b697463682e706e67)



- パラグラフ内でのInterpreterの利用

  Notebook-Tutorial1の内容をもとに、パラグラフを利用方法を確認します。

  「Notebook」→ 「Journeys」→「New Data Lake」→ 「Tutorial1 Notebook Basics」をクリックします。

![](https://camo.githubusercontent.com/2cab181b350ee7832c1ebc00b238936e5abc0c1d/68747470733a2f2f7777772e657665726e6f74652e636f6d2f73686172642f7336322f73682f37343639353265372d376332662d343230352d393165652d6664343030643365623935372f313661616266613939343661623833662f7265732f37663034366130332d366262322d343064622d616331312d6639326237666537643565612f736b697463682e706e67)



### ワークショップで取り扱うデータセット（Citi Bike New York Cityデータ）の確認

本ワークショップで取り扱うデータセット（Citi Bike New York Cityデータ）について内容を確認します。

- データ取得元：[citibike system data](https://www.citibikenyc.com/system-data)
- データ形式： 
  - 日付ごと等のバッチファイル形式：CSV
  - リアルタイム形式：JSON
- データ項目：
```
Trip Duration (seconds)
Start Time and Date
Stop Time and Date
Start Station Name
End Station Name
Station ID
Station Lat/Long
Bike ID
User Type (Customer = 24-hour pass or 3-day pass user; Subscriber = Annual Member)
Gender (Zero=unknown; 1=male; 2=female)
Year of Birth
```

- データサンプル

```
"tripduration","starttime","stoptime","start station id","start station name","start station latitude","start station longitude","end station id","end station name","end station latitude","end station longitude","bikeid","usertype","birth year","gender"
695,"2013-06-01 00:00:01","2013-06-01 00:11:36",444,"Broadway & W 24 St",40.7423543,-73.98915076,434,"9 Ave & W 18 St",40.74317449,-74.00366443,19678,"Subscriber",1983,1
693,"2013-06-01 00:00:08","2013-06-01 00:11:41",444,"Broadway & W 24 St",40.7423543,-73.98915076,434,"9 Ave & W 18 St",40.74317449,-74.00366443,16649,"Subscriber",1984,1
2059,"2013-06-01 00:00:44","2013-06-01 00:35:03",406,"Hicks St & Montague St",40.69512845,-73.99595065,406,"Hicks St & Montague St",40.69512845,-73.99595065,19599,"Customer",NULL,0
123,"2013-06-01 00:01:04","2013-06-01 00:03:07",475,"E 15 St & Irving Pl",40.73524276,-73.98758561,262,"Washington Park",40.6917823,-73.9737299,16352,"Subscriber",1960,1
```

### データレイク環境（Object Storage）へのデータのロード

データレイク環境（Object Storage）にデータをロードする方法はいくつかあります。以下に例を示します。
- 3rdPartyクライアントツール（CloudBerry等）
- SDKの利用
- OCI-CLIコマンドの利用
- ObjectStorage接続コネクタの利用
- Big Data Cloud Consoleの利用
- Zeppelin Notebookの利用
- 等

####  Zeppelin Notebookを用いたデータのロード

Notebookの「Tutorial 2: Introduction to Citi Bike New York and SetupTutorial 2: Introduction to Citi Bike New York and Setup」の「Shell commands to download data and copy data to Object Storage」を実行します。

![](https://camo.githubusercontent.com/252c77498147a765e814624675ba3ec5bd8acf9f/68747470733a2f2f7777772e657665726e6f74652e636f6d2f73686172642f7336322f73682f30636262633765362d636261632d343866352d623230612d6665393331636234383530372f333262626234346161323661323162372f7265732f64303464393134382d643632362d346334302d383862302d3863396138643038346231662f736b697463682e706e67)

![](https://camo.githubusercontent.com/f6b1e69198ac4ae31f4f37310b0a241988ca47a9/68747470733a2f2f7777772e657665726e6f74652e636f6d2f73686172642f7336322f73682f64373262336330642d626566332d343139662d396533662d3465643138363235383230642f633436303538376463383633343334382f7265732f61316439376431622d363061382d343136622d613966382d6664616139326133323739662f736b697463682e706e67)

上記により、以下の状態となります。

- https://www.citibikenyc.com/system-data からファイル”201612-citibike-tripdata”がダウンロードされる
- Object Storageにディレクトリ”/citibike/raw”、”/citibike/modified”が作成される
- ”201612-citibike-tripdata”ファイルを編集したファイル（ヘッダー業を削除）を”/citibike/modified”に保存、編集前のファイルを”/citibike/raw”に保存する


参考までに、Notebook以外の方法でObject Storageにアクセスする方法を例示します。

#### Big Data Cloud Consoleの利用

1. Big Data Cloud Consoleを開く
2. 「Data Stores」を選択
3. 「Cloud Storage」を選択
4. 右側のペインで該当するファイルにアクセス

![](https://www.evernote.com/shard/s62/sh/c5baa9f1-a66a-409c-8a0a-199cce949c6a/4ac958dcf74b8748/res/df8c222c-5aaa-489c-845e-c4941ea49f2d/skitch.png)



####  OCI-CLIコマンドの利用

```
$ oci os object put -bn test01bdc01 --file 201611-citibike-tripdata.zip
{
  "etag": "22d58e32-7a42-4e07-af9a-50f60b7c7e6e",
  "last-modified": "Thu, 07 Feb 2019 07:52:38 GMT",
  "opc-content-md5": "iAz8MNlbqVJVkzddOL8Fpg=="
}
$ oci os object list -bn test01bdc01 |jq '.data[]|."name"'
".DS_Store"
"201611-citibike-tripdata.zip"
・・・
```

#### ObjectStorage接続コネクタの利用

spark/hadoop経由で以下のパス名でObjet Storageにアクセス
``` oci://バケット名@テナント名/ファイルパス```

（例）テナント名"bar" バケット名 "foo" ファイルパス "/dir1/file1.csv"へのSparkアクセス

```
val bankText = sc.textFile("oci://foo@bar/dir1/file1.csv")
bankText.count()
```



###   データレイク環境（Object Storage）のデータの操作

データレイク環境（Object Storage）のデータを操作する方法はいくつかあります。ここではHive、Sparkを用いたデータ操作について例示します。

#### Hive

Notebookの「Tutorial 3: Working with Hive」の内容に沿って、Hiveを用いたデータ操作を実施します。

主に以下の操作を実施します。

- Hiveテーブルの作成およびデータのロード（HDFS版）
- Hiveテーブルの作成およびデータのロード（Object Storage版）
- HiveデータへのSQLアクセス
- JDBC経由でのHiveアクセス

#### Spark

Notebookの「Tutorial 4: Working with the Spark Interpeter」の内容に沿って、Hiveを用いたデータ操作を実施します。

主に以下の操作を実施します。

- Object Storage上のデータを用いてDataFrameおよびViewを作成する
- SparkSQLで上記Viewにアクセスする
- アクセス結果をVisual表示する
- 上記ViewのデータをHive /w parquetフォーマットで永続化する












