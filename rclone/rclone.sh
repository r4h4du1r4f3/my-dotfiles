#! /bin/bash

rclone mount SAM_Anime: "/home/rafee/SAM FTP/SAM Anime" --read-only &

rclone mount SAM_Series: "/home/rafee/SAM FTP/SAM Series" --read-only &


rclone mount CircleFTP_Anime: "/home/rafee/SAM FTP/CircleFTP Anime" --read-only &

rclone mount CircleFTP_Series: "/home/rafee/SAM FTP/CircleFTP Series" --read-only &