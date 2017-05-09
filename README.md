# Map
### Markit Framework
* 授權; requestWhenInUseAuthorization:只有使用App時,才能取用位置。 requestAlwaysAuthorization: App永遠可以取用位置,包括於背景執行時 Apple建議,非必要請盡量使用requestWhenInUseAuthorization,以便於可以更加的維持User的隱私安全,若您的App沒有明顯的理由非用 requestAlwayAuthorization不可的話,送審時,也有可能會被Apple 給擋下來,要求您修改或者說明另外,此機制將需要配合在info.plist中加入額外的內容才行,至於選擇使用 NSLocationWheninUseUsage Description或者 NSLocationAlwaysUsageDescription,將需要搭配您程式碼中對於授權方式的選擇而定。iOS8時您務必要於取得授擅時,配合NSLocationWheninUseUsageDescription或者 NSLocationAlwaysUsageDescription到info.plist。
* iOS10之後, Info.plist加上隱私的聲明敘述名稱改為: Privacy-Location Always 2, Usage Description或Privacy-Location When In Use Usage Description。
* 若採用requestWhenInUseAuthorization的權限,讓App於背景執行時,會看到有提示,雖然出現此提示,並不代表您的App可以持續的於背景取用位置, iOS會於某個適當時機中止您App的位置回報,若您要開發長時間背景定位的App的話,建議使用 requestAlwaysAuthorization會比較妥當。
***
* GPS的座標系統採用的是WGS84系統,經緯度的表示方式有多種,Google Maps及iOSSDK採用的格式是:(緯度,經度) → 24.5587631,120.7760446。經緯度的表示與紀錄在小數點下六至八位為佳。 
* iOS裝置並不是只仰賴GPS來定位iOS提供了三種定位的方式,甚至於在某些情況下還可以交互應用這三種方式來達 到最省電又最接近所需精確度的定位效果。
* GPS定位:使用衛星來定位,只能在戶外進行,非常耗電,有時需要等很久,不須 仰賴網路功能,精確度可達3至5米。
* WiFi定位:使用周邊的WiFi基地台,透過複雜的數學運算後,得出目前User的 位置,在室內、室外皆可使用,相當省電,在網路狀態好的情況下,只需要數秒鐘 就可以得知概略的位置,但一定需要有網路連線,精確度可達15至100米。
* Cell定位:使用周邊行動電話基地台,透過複雜的數學運算後,得出目前User的位置,室內、室外皆可使用,非常省電,在網路狀態好的情況下,只需要數秒鐘就 可以得知概略的位置,但一定需要有網路連線,精確度可達200至3000米 ● 提供這種複合式的定位技術,替iOS裝置帶來了如下的優勢 1,省電:在不需GPS精確度的場合,使用WiFi與Cell的定位只需GPS的百分之 的電力消耗,就可以提供一個概略的且足夠作為參考的位置,對於行動裝置而言 這會是非常重要的一點。 2、沒有GPS硬體也可以定位: iPod Touch與iPad WiFi版的裝置是沒有內建GPS 的,但仍可以具有基本的定位能力,也可以運用LBS相關的應用 3.室內定位:由於不是一定要仰賴GPS,這使得LBS的便利性大增,在室內也可以 做定位使得iOS平台在具有非常適合發展LBS條件 但也是有缺點的,包括: 1.只能取得Apple提供的資訊:無法取得底層更細節的資訊,例如:GPS的 NEMA串流內容。 2,有時會無法掌握定位的狀況,以至於App無法提供適切的提醒訊息給User。 
