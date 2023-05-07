//! [1] we can do it manually => 
// environment:
//   sdk: if less than 2.12 change to new one
// environment:
//   sdk: '>=2.19.6 <3.0.0'

// then correct errors one by one

//! [2] 
//* 1. check is package you used inside your project support null safty
//? => flutter pub outdated --mode=null-safety
//* edit old with new version according what you get
//? => flutter clean   ==> flutter pub get
//* then reensure
//? => flutter pub outdated --mode=null-safety

//* 2. now use
//? => dart migrate
//! it give us a link, visit it to review our code then =>apply migration
