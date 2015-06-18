#!/bin/sh 
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then   
	echo "This is a pull request. No deployment will be done."   
	exit 0 
fi 
if [[ "$TRAVIS_BRANCH" != "master" ]]; then   
	echo "Testing on a branch other than master. No deployment will be done: $TRAVIS_BRANCH"   
	exit 0 
fi

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_NAME.mobileprovision" 
OUTPUTDIR="$PWD/build/Release-iphoneos" 

echo "***************************"
echo "*        Signing          *"
echo "***************************"
xcrun -log -sdk iphoneos PackageApplication "$OUTPUTDIR/$APP_NAME.app" -o "$OUTPUTDIR/$APP_NAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE"

zip -r -9 "$OUTPUTDIR/$APP_NAME.app.dSYM.zip" "$OUTPUTDIR/$APP_NAME.app.dSYM"


echo "***************************"
echo "*      Release Notes      *"
echo "***************************"
RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
MAJORMINOR=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "$INFO_PLIST")
#The PList was updated in UPDATE-BUNDLE.SH
BUILDNUM=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "$INFO_PLIST")
#gets the last tag
PREVBUILD=$(git describe --abbrev=0 --tags)
git pull --tags #this must be after PREVBUILD
#Tag the build, but skip this commit
#git commit -am "[ci skip]Tagging build"
git tag $MAJORMINOR.$BUILDNUM
#while this push will increment the build number, it's pushed to a weird 'branch', so it won't deploy
#git push --tags
#GET COMMITS SINCE LAST TAG- removed the ^ after $PREVBUILD so we dont print the $PREVBUILD commit msg too
LOG=$(git log --no-merges --decorate $PREVBUILD..$MAJORMINOR.$BUILDNUM)
RELEASE_NOTES="Version: $MAJORMINOR.$BUILDNUM \n Uploaded: $RELEASE_DATE \n\n $LOG"
echo $RELEASE_NOTES
touch "RN/v$MAJORMINOR-$BUILDNUM.txt"
echo $RELEASE_NOTES > "RN/v$MAJORMINOR-$BUILDNUM.txt"

git add -A .
git commit -am "[ci skip] Tagging build, Updating RNs"
git push --tags origin master


#if [ ! -z "$HOCKEY_APP_ID" ] && [ ! -z "$HOCKEY_APP_TOKEN" ]; then
#  echo ""
#  echo "***************************"
#  echo "* Uploading to Hockeyapp  *"
#  echo "***************************"
#  RTN=$(curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_APP_ID/app_versions \
#    -F status="2" \
#    -F notify="1" \
#    -F notes="$RELEASE_NOTES" \
#    -F notes_type="0" \
#    -F ipa="@$OUTPUTDIR/$APP_NAME.ipa" \
#    -F dsym="@$OUTPUTDIR/$APP_NAME.app.dSYM.zip" \
#    -H "X-HockeyAppToken: $HOCKEY_APP_TOKEN")
#  echo $RTN
#fi

  echo ""
  echo "****************************"
  echo "* Uploading to Crashlytics *"
  echo "*                          *"
  echo "*  Note- Creds not secure  *"
  echo "*                          *"
  echo "*                          *"
  echo "****************************"
./Crashlytics.framework/submit 916ca320e4327b0f5bdb17e64886867e0fec2d92 9d76d55f6993f7825640bc0a9fb2c9d5c7fa9ea212962e031df8d3b2a5ff9570 \
    -ipaPath "$OUTPUTDIR/$APP_NAME.ipa" \
    -notifications YES \
    -groupAliases IOS \
#-notesPath "RN/v$MAJORMINOR-$BUILDNUM.txt"

