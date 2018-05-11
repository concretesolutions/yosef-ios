rm -Rf ~/Library/Developer/Xcode/DerivedData/*
rm -Rf coverage_report
xcodebuild clean build -workspace Example/Yosef.xcworkspace -scheme Yosef-Example test -sdk iphonesimulator -configuration Debug -destination 'platform=iOS Simulator,OS=11.3,name=iPhone 8 Plus'
bundle exec slather --verbose
open coverage_report/index.html
