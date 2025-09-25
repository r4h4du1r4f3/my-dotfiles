#! /bin/bash

rclone mount SAM_Anime: "/home/rafee/SAM FTP/S Anime" --read-only &

rclone mount SAM_Series: "/home/rafee/SAM FTP/S Series" --read-only &

rclone mount CircleFTP_Anime: "/home/rafee/SAM FTP/C Anime" --read-only &

rclone mount CircleFTP_Series: "/home/rafee/SAM FTP/C Series" --read-only &

