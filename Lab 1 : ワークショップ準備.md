#Big Data Journey Lab 1 : ワークショップ準備

##コンテンツ

- ワークショップストーリーの理解
- オラクルクラウド（Oracle Cloud Infrastracutre:OCI）へのアクセス
- データレイク環境のセットアップ
- データレイク環境へのアクセスおよびワークショップノートの取り込み

###ワークショップストーリーの理解

本ワークショップのストーリーを以下に記載します。

- 背景
  - NewYork Cityでレンタル自転車サービスを展開
  - 大きく２つの課題
    - ステーションに自転車がなく、自転車を必要とするお客様にサービスを提供できないときがある
    - ステーションに空きスペースがなく、自転車を返却できないときがある
  - 上記課題を解決するためのプロジェクトチームが発足
  - 上記プロジェクトチームでは、上記の課題解決に向けたデータ分析および課題解決に向けた施策の実施をゴールとする
- 利用するデータ
  - bike tripデータ 
    New Yorkのレンタル自転車のデータ。Internet上で一般公開されています。
  - 気象(weather)データ
    分析対象期間のNew York Cityの気象データ
  - イベントカレンダー
    平日と休日を区別するためのカレンダーデータ
- 本ワークショップで用いるデータレイクのイメージ


  ![](https://raw.githubusercontent.com/millerhoo/journey2-new-data-lake/master/workshops/journey2-new-data-lake/images/snap0012028.jpg)



### オラクルクラウド（Oracle Cloud Infrastracutre:OCI）へのアクセス

本ワークショップでは割愛します。手順等は以下URLの内容をご確認ください。

[Oracle Cloudを無料で使用開始](https://cloud.oracle.com/ja_JP/tryit)

[ チュートリアル : Oracle Cloud Infrastructure を使ってみよう](https://community.oracle.com/docs/DOC-1019313)


### データレイク環境のセットアップ

データレイク環境をセットアップします。

参考：[Getting Started with Oracle Big Data on Oracle Cloud Infrastructure](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/bdcsce/E97993_01_gs_bdc_oci/getting_started_oci.html)


### データレイク環境へのアクセスおよびワークショップノートの取り込み

- URL/ノートブックアクセス
  上記でセットアップしたデータレイク環境のNotebookにアクセスします。

Dash Boardのハンバーガーメニューから「Big Data - Compute Edition」を選択します。

![](https://camo.githubusercontent.com/14f55c50352878f1f707908b9968c286a71084fa/68747470733a2f2f7777772e657665726e6f74652e636f6d2f73686172642f7336322f73682f34656539353833342d306230312d343134372d613163612d6262636663336236363339312f383737653261326133383861323634312f7265732f38383732343866302d363866322d343736382d613031322d3433393364336433306236392f736b697463682e706e67)



該当するインスタンス（環境）のみ右上にあるアイコンをクリックし、「Big Data Cloud Console」をクリックします。

![](https://camo.githubusercontent.com/96d1ee660db0373a64af23e05331ebdec8936038/68747470733a2f2f7777772e657665726e6f74652e636f6d2f73686172642f7336322f73682f66336537353433372d356162332d343336372d613138652d3331386665643064386236392f613539363766333032663037623964392f7265732f38373333393564642d663265332d343238332d393536632d3231633932303030383939622f736b697463682e706e67)



Big Data Cloud Consoleが表示されるので、メニューから「Notebook」を選択します。



![](https://camo.githubusercontent.com/bdd1aa3289cabb7c7ff09c33491ab3e20e9ee851/68747470733a2f2f7777772e657665726e6f74652e636f6d2f73686172642f7336322f73682f62333166653232622d626566312d343562302d626433652d3732323765613730363638642f633430363836366133323364393663332f7265732f65663963666238652d636564652d343136352d613331632d6234323661643136636530632f736b697463682e706e67)




- SSHアクセス
  データレイク環境にSSHでアクセスし、ワークショップ用のNotebookを取り込みます。

（参考）[インスタンスへの接続](https://docs.oracle.com/cd/E97706_01/Content/GSG/Tasks/testingconnection.htm)


  

- ワークショップ用Notebookの取り込み
  ワークショップ用のNotebookを取得します。以下の操作を実施します。

```bash
# BDCのホスト名を/etc/hostsに登録
sudo sh -c 'echo "x.x.x.x hoge" >> /etc/hosts'

# BDCにSSH接続
ssh opc@hoge
```

```
Are you sure you want to continue connecting (yes/no)? yes
```

```bash
# Notebook＋Dataの取り込み
sudo bash
wget -nc https://raw.githubusercontent.com/millerhoo/journey2-new-data-lake/master/workshops/journey2-new-data-lake/files/100/bootstrap.sh
chmod u+x bootstrap.sh
./bootstrap.sh
echo "done"
```

- Notebookの再起動

取り込んだNotebookを反映するためにNotebookを再起動します。

![](https://camo.githubusercontent.com/41bd7259329a18c5e9f6a5b2a70b056a5187dd54/68747470733a2f2f7777772e657665726e6f74652e636f6d2f73686172642f7336322f73682f64316638326361312d346433622d343861382d383130382d3261616133613763633665622f653333386130636161626430303033382f7265732f61356165626631652d333562392d346630612d616535332d6661306630613066346366622f736b697463682e706e67)

