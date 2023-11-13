find  $1 -type f \( -name "*.avi" -o -name "*.AVI" \)  -print0 | xargs -t0 -n 1 -P 10 -I XX  ffmpeg -i XX -c:v copy  -c:a aac -b:a 128k XX.mp4 -n \; > $1/conversion_results.out
