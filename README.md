[README.md](https://github.com/user-attachments/files/21799237/README.md)
# 📱 BeHard — New Friends Screen (Take‑Home Assignment)

The app has two modes:

•  Demo mode — uses fully mocked data with simulated loading delays.

•  Live mode — works with real data from Firebase.


You can switch modes by changing the isDemo flag in Constants.swift file Utilities folder. By default it set to false.

The project is built with vanilla SwiftUI, using mocks and services that can later be adapted to any architecture or used simply for testing.

All views in the project are fully mocked and displayed in SwiftUI previews.
Feel free to modify the preview data or switch between different view states to explore various UI scenarios.


In the navigation bar, the “+” button on the left behaves differently depending on the mode:
  •  Demo mode — adds random mocked progress data for a random user.
  •  Live mode — creates a new progress entry in Firebase, triggers a local push notification, and updates the UI in real time.
  
  
To test real-time updates from Firebase, manually add a new document to the task_progress collection using existing IDs:
  •  Challenge IDs:
jfqPyEOteqx5Md0DssRn
nq15RyI96iKwej8UHDFY
rb93DckPmhLy1o9IdZwh
  •  User IDs:
3GJgLI9S3AOGZHZCPesQ
IMwMUCJEpVkSI4k7tjU0
LGYPBZRsqoS0vZPpZRm6
cPSLPyEKCIbYpc7MqrLO
lMU1ejhv2pfkmittKATK
  •  Task IDs:
VLEtzjyJw2EU7uLwYqLK
dKM0a6RtdCmQsZKcDhWR
fnsKykb1FZlLuW2JK4Sa
n1ZYPR4XMUfdhDUtqWCe
uB4M7UultujTBcw7ZgsX

Make sure that the progress_dates field is an array of valid date values.
Once the document is added, the app will display the new progress entry instantly.



<img width="1129" height="376" alt="Снимок экрана 2025-08-15 в 18 45 11" src="https://github.com/user-attachments/assets/f21c88f0-f5ac-48d2-9d3e-28109da46aec" />



The empty activity state can be tested by running the app the following day — the screen will display a placeholder indicating that there is no activity.


The emojis are clickable a little 😉


This assignment was a pleasure to work on, and I found the design and real application very interesting:)


If you have any questions, feel free to reach out via Telegram @pavlo_bezkorovainyi or email at beskor1993@gmail.com.



  
  



