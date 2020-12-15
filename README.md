# FetchRewardsEvents

An app that utilizes the [SeatGeeks API](https://platform.seatgeek.com/) to search events and you can persist them as well.

<img src=https://github.com/Agarrovi1/FetchRewardsEvents/blob/main/Images/FetchRewardsScreenShot.png alt=Example width=343 height=743>

# Instructions:
1. Clone the app
2. Delete the Secrets.swift file and create a new one with the same name
3. Copy into Secrets.swift this code snippet below

```swift
struct Secrets {
    static let clientId = ""
}
```
4. Paste in your [SeatGeeks](https://seatgeek.com/?next=%2Faccount%2Fdevelop#login) Client ID into clientId property
