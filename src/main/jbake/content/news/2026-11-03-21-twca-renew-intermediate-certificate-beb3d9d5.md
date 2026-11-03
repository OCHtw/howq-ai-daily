title=TWCA中繼憑證序號亂數不足遭Mozilla揭露，將於026年11月6日被廢止，全台各機關網站全面更新
date=2026-11-03
dateModified=2026-11-03
source_date=2026-10-31
type=news
status=published
category=產業消息
tags=資安
source_name=www.twca.com.tw
source_url=https://www.twca.com.tw/news_detail/5f3395bf-bef6-4b40-b922-ceac4b06bf53
image=
summary=臺灣網路認證公司(TWCA)核發的部分中繼憑證，因「序號隨機亂數長度(TWCA)核發的部分中繼憑證，因「序號隨機亂數長度（Entropy)」未達國際安全標準，遭Mozilla外部社群通報，依國際規範，舊有的不合規中繼憑證必須在2026年11月6日00:00前完成廢止(Revoke)。導致大量政府機關與企業網站必須在2026年11月6日前緊急完成憑證換發。
tldr1=台灣962個政府機關，共9772張網站TLS憑證，受到影響。
tldr2=
tldr3=
faq1Question=為何會臨時發生不合規範？
faq1Answer=因2016年憑證規範調整時，少改了CA端憑證產製64 bits亂數規範，所以10年來都沒發現，近期才被外部研究人員分析，其序號隨機亂數長度未達國際標準，台灣近乎全數政府網站必須在 7天內緊急強制換發。
faq2Question=如果未及時更換會如何？
faq2Answer=若未在期限內更換，原有的中繼憑證一旦被國際瀏覽器撤銷(Revoke)，民眾訪問這些網站時，瀏覽器就會跳出「此網站安全性憑證不安全／連線不安全」的警告封鎖畫面，影響正常連線。
faq3Question=
faq3Answer=
preview=
~~~~~~

> 小編無語！！

<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=2087236" target="_blank" rel="noopener noreferrer">TWCA: CA certificate serial numbers contain fewer than 64 bits of CSPRNG output ↗</a>


