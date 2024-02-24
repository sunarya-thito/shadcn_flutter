cmd /c flutter build web --release --base-href=/shadcn_flutter/
echo "copying build/web/* to ../docs"
xcopy /E /Y build\web\* ..\docs\