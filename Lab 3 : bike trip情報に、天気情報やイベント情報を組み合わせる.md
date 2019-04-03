# Big Data Journey Lab 3 : bike trip情報に、天気情報やイベント情報を組み合わせる
## コンテンツ

- 天気情報の取得
- SparkSQLでアクセスする
- イベント情報の取得（作成）
- Citi Bikeデータと上記データを組み合わせる

### 天気情報の取得

National Centers For Environmental InformationサイトのClimate Data Onlineから分析対象期間に該当するデータをダウンロードします。

- URL：https://www.ncdc.noaa.gov/cdo-web/
- 分析対象期間 ： 2016-12-01 to 2016-12-31
- 対象地域 ：New York City
- データ項目 ： 
  - PRCP - 降水量
  - SNWD - 積雪量
  - SNOW - 降雪量
  - TAVG - 平均気温
  - TMAX - 最高気温
  - TMIN - 最低気温
  - AWND - 平均風力


サイト概要とダウンロード手順をいかに示します。

![CDO](https://raw.githubusercontent.com/millerhoo/journey2-new-data-lake/master/workshops/journey2-new-data-lake/images/300/snap0012665.jpg)



![CDO2](https://raw.githubusercontent.com/millerhoo/journey2-new-data-lake/master/workshops/journey2-new-data-lake/images/300/WeatherOrder.gif)



![CDODownload](https://raw.githubusercontent.com/millerhoo/journey2-new-data-lake/master/workshops/journey2-new-data-lake/images/300/WeatherDownload.gif)

---

※ 本ワークショップで用いるデータは以下から取得することも可能です。

```
https://raw.githubusercontent.com/millerhoo/journey2-new-data-lake/master/workshops/journey2-new-data-lake/files/1090166.csv
```


Notebookの「Tutorial 4b: Adding more datasets」
に準備している"Script to download weather data and upload to Object Store"スクリプトを用いて、上記サイトからデータをダウンロードし、ObjectStorageにデータをアップロードします。


###  SparkSQLでアクセスする	

- ObjectStorageのデータを読み取る
- Sparkテーブルを作成する
- 作成する際、データをBDFS領域にデータをキャッシュする

上記のあと、SparkSQLでデータにアクセスできるようになります。
例として次のSQLを実行します。

```
select * from weather_tempwhere NAME like '%CENTRAL%'
```

```
select cast(date as date) day_of_month, tmax, tmin, prcp*20 prcp_scaled
from weather_temp
where station='USW00094728'
order by day_of_month
```

### イベント情報の作成（取得）

weather情報に加えて、イベント情報（カレンダー：平日と休日）を加えて分析できるようにします。

本来なら、外部からデータを取得 → インポートとしますが、ここでは、休日データ・セットを作成の上、曜日情報（土曜日・日曜日）と加えて休日とします。

休日データ・セットを作成

```
val hdf = Seq("2016-12-24", "2016-12-25", "2016-12-26", "2016-12-31").toDS()
hdf.createOrReplaceTempView("holidays_temp")
```


### Citi Bikeデータと上記データを組み合わせて分析する

これまでに作成したテーブル（Weather、休日）と、trip情報とを組み合わせます。

- テーブル（Weather情報）とテーブル（休日）とを組み合わせたSQLを実施
- テーブル（Wather情報）、テーブル（休日）、テーブル（trip情報）とを組み合わせたSQLを実施
- 上記のSQL結果をもとにテーブル（Parquetフォーマット）を作成
- 以下のSQLを実施
  - 日毎のtrip件数およびその日の天気や曜日
  - workdayの時間ごとのtrip件数
