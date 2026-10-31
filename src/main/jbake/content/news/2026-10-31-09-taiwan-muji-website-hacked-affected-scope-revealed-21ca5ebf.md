title=91APP資安事件受害品牌台灣無印良品公告資料庫遭駭
date=2026-10-31
dateModified=2026-10-31
source_date=2026-10-30
type=news
status=published
category=產業消息
tags=資安,Insight,Tip
source_name=聯合新聞網
source_url=https://udn.com/news/story/7270/9847893
image=https://pgw.udn.com.tw/gw/photo.php?u=https://uc.udn.com.tw/photo/t3/2026/10/30/35470855.jpg&M=1&s=Y&x=0&y=0&sw=948&sh=632&exp=3600
summary=台灣MUJI無印良品公告表示，經初步確認，可能受影響之範圍包括2025年4月4日至2026年10月14日於MUJI無印良品官網購物之訂單，資料欄位包括姓名、電話號碼、配送地址、電子郵件（如有填寫）及訂單紀錄，但不包含信用卡資訊及會員登入密碼。
tldr1=91APP爆發重大資安事件，公司證實，最大影響品牌數達1329家，可能影響消費者479萬8255人。
tldr2=
tldr3=
faq1Question=91APP如何遭駭？
faq1Answer=攻擊者使用ARTEX AI自動化攻擊工具，利用未及時修補的Appsmith漏洞入侵內部系統，非法存取Commerce Cloud訂單資料。
faq2Question=小編覺得未來的系統資案架構該如何思維？
faq2Answer=漏洞一定會持續不斷被找出，所以系統架構重點應該要在被突破時，「機敏資料要能最小程度露出」
faq3Question=
faq3Answer=
preview=台灣MUJI無印良品於官網發布聲明公告，指出於2026年10月29日接獲第三方雲端服務商「91APP」通知，其訂單資料庫被駭，經確認MUJI無印良品官網購物部分訂單資料亦存放於該資料庫中，已立即啟動應變措施，並於10月30日向主管機關及相關單位通報。
~~~~~~


近期也許因為AI助攻，感覺每週都有重大資安事件。

小編多次工作於資安要求高的SaaS，明顯感覺91APP在軟體開發的資安治理上有疏失。但也能體會工程師們有些事知道要怎麼做比較安全，但實際做起來有點麻煩，某甲偷懶一步、某乙沒注意到、某丙根本專業不足，累加起來內部都是漏洞。


> 小編站著說話不腰疼，但覺得應該有件事可以讓小編在新系統設計要注意：   
> **漏洞一定會持續不斷被找出**，所以系統架構重點應該要在被突破時，
> **「機敏資料最小程度露出」**



事件整理相關內容如下：

### 91APP公司重訊

國內電商技術服務龍頭91APP爆發重大資安事件後，經過25天調查，召開重訊記者會公布調查結果，因為旗下合作品牌，從運動運品、生活百貨直到家電食品，影響範圍大，公司證實，最大影響品牌數達1329家，可能影響消費者479萬8255人。

  * 入侵發生日：115/10/3。
  * 事實確認日：115/10/14。
  * 通報客戶日：115/10/15。
  * 發生緣由：Commerce Cloud 資料庫受到自動化攻擊。
  

### 遭駭的 Commerce Cloud

<a href="https://91app.com/commerce-cloud?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">Commerce Cloud官網說明 ↗</a>

主要業務：品牌專屬官網與 App。


### 主要爭議

未及時提醒品牌客戶直到品牌客戶遭受詐騙，才雲淡風輕的承認。

91APP遭駭稱「營運無重大影響」，電商老闆：扛消費者怒火的是我們。


### 受影響品牌

台灣MUJI無印良品、全家行動購、adidas、CAFE!N、快車肉乾、新普利、臭味滾ODOUT、hoi! 好好生活、PAUL & JOE、益比喜、聯夏食品、中化裕民健康商城、Allre歐瑞生醫、雙全生活館、滿心munsin、荷麗美加、Urban Units、ELEMIS、買Targus、德創生技、愛車褓母、airbubu、CleanClean、凱娜小棉條兒俱樂部、志光保成、大侑 Diet-U、天藍小舖、EASY SHOP、康軒親子網、愛富發、AirealLand年零、WEDAR薇達、樂入優選、CY JOYCE 喜悅、mini matters、rezzer、Columbia Sportswear、尖端出版、LOVFEE、ASICS、mySelect優品選、摩曼頓、東海模型、唯有機、S'AIME、MT可乘、Unicorn、STORY故事銀飾、相信音樂、娘家、Tapazo等。


### 何謂自動化攻擊

這次發現ARTEX AI自動化攻擊工具的痕跡。

駭客透過AI系統協同運作，過去需要耗費數天的人工弱點掃描、後門測試與權限探測，AI幾秒鐘內就能自動執行完畢。攻擊的頻率與廣度遠超過以往，攻擊門檻大幅降低。

> 小編覺得現在手中有大量客戶資料的SaaS會是各駭客口中肥羊。
> 不過工具值得研究一下用來偵測自己網站的弱點。
> <a href="https://github.com/trhhubsd/ARTEX?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">GitHub - ARTEX ↗</a>


### 此次駭客攻擊過程

參照 <a href="https://91app.com/91app-202610-security-incident?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">91APP 遭受駭客攻擊事件說明與後續補償計畫 ↗</a>


  - 駭客找到內部使用的第三方工具Appsmith(開源Low-Code開發平台，主要用途是讓開發者透過Drag-and-Drop，快速建立各種企業內部工具與網頁應用程式)存在漏洞。
  - 駭客透過漏洞進入內部網路，再從GitLab取得一組資料庫的存取金鑰。
  
> 小編覺得 key在 GitLab很不ok，但也知道這樣布版方便。正常作法應在是放在主機的環境變數，由非開發者透過高權限管制的方式發送至各主機。開發者與布版者不應該知道營運key。
  
  - 從CI主機連到資料庫。
  
> 小編認為可以連線到營運資料庫的主機，本來就會透過防火牆控管吧！？應該只有特定營運服務主機可以讀取。怎會讓非服務主機可連上。
  
  - 進而存取訂單資料。

> 這是另一個值得思考但做起來比較難的部分，由於這個Commerce Cloud服務是替客戶建置自有官網與APP，所以理論上也能讓服務主機連線資料庫時，只能讀取部分資料(Row-level 的db user權限或View，不是透過ap傳條件篩選資料)。這樣可以減低受害資料範圍，當然這次事件key都在GitLab分再多把也沒用。

  - 從訂單資料找出交易者姓名、電話號碼、配送地址、電子郵件（如有填寫）及訂單紀錄，然後資料應該是被駭客販售給犯罪集團，並開始進行詐騙。

> 有一個長久的議題，部分資料是否應該加密。目前業界共識是密碼一定是要進行不可逆加密。但將電話、地址、電子郵件進行可逆加密也是討論中事項，只是既然是可逆則只要key被偷依舊沒用，所以業界實作的很少。


