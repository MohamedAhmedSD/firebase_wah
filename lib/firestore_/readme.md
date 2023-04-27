# Cloud FireStore == realtime DB == CRUD
- rules
- Collection > doc == [row our result from certain collection]
- [users_,notes]
- we can make nested collection => it collection inside doc as { address : country, city, street}
- doc may have multi fields && multi collections
- array is one type from data we can use it, from doc fields
- we can connect 2 collections by use its collection id in second one, as value
- as => a [id = 22] b [ aid = 22]

# note app
- notes for certain user => use userid as notes id => if user add more than one note???
- is better make collection nested inside our doc [ notes => notes => fields]
- Second way => add field contain userid on notes field


# how we get data from cloud by code
- import cloud firestore
- make function to get data (future)