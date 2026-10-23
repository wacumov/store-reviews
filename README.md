# store-reviews

Shows the App Store rating prompt. Keeps the app from showing it too often.

```swift
import StoreReviews

await Reviews.requestIfNeeded()                      // at most once every 120 days
await Reviews.requestIfNeeded(daysBetweenPrompts: 90)
await Reviews.requestManually(appID: "123456789")    // opens the write-review page
```

`requestIfNeeded()` shows the prompt only if both of these are true:

- the app did not show it for this app version (`CFBundleShortVersionString`);
- the app did not show it in the last `daysBetweenPrompts` days.

iOS also has its own limit: three prompts per year.

Call it after a good moment, for example when the user saves something. Do not call it when a screen opens.
