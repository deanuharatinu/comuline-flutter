echo "================================================"
echo "⌛️ Installing flutter dependencies"
echo "================================================"

flutter pub get;
dart run build_runner build --delete-conflicting-outputs; 

echo "================================================"
echo "Done"
echo "================================================"
