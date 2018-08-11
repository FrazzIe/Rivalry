local emergency_users = {}
local pay = {
	["10-15"] = 50,
	["10-31"] = 50,
	["10-32"] = 50,
	["10-90"] = 50,
	["311"] = 25,
	["911"] = 25,
}

Chat.Template("policethreeoneone", "<img src=\"data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA1MTEuOTk5IDUxMS45OTkiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMS45OTkgNTExLjk5OTsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIxNnB4IiBoZWlnaHQ9IjE2cHgiPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0zMTEuMjkzLDMzMi42MTNjLTE2LjcyLDcuOTI4LTM3LjI4NSw1LjE1OC01MS4xLTguNjU3bC03Mi4xNDktNzIuMTVjLTEzLjgxNS0xMy44MTUtMTYuNTg2LTM0LjM3OC04LjY1Ny01MS4wOTggICAgTDUwLjEwNiw3MS40MjZMMzkuNDk0LDgyLjAzNWMtNTIuNjU5LDUyLjY2MS01Mi42NTksMTM4LjMzMSwwLDE5MC45OTJsMTk5LjQ3OCwxOTkuNDc4YzUyLjY1OSw1Mi42NTksMTM4LjMzMSw1Mi42NTksMTkwLjk5MSwwICAgIGwxMC42MTEtMTAuNjExTDMxMS4yOTMsMzMyLjYxM3oiIGZpbGw9IiNEODAwMjciLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik00NzMuODA3LDM2NS41OThsLTYzLjY2NC02My42NjJjLTE3LjU1NC0xNy41NTQtNDYuMTEtMTcuNTU0LTYzLjY2NCwwbC0xMC42MDksMTAuNjA5bDEyNy4zMjYsMTI3LjMyOGwxMC42MTEtMTAuNjExICAgIEM0OTEuMzYsNDExLjcwOCw0OTEuMzYsMzgzLjE1MSw0NzMuODA3LDM2NS41OTh6IiBmaWxsPSIjRDgwMDI3Ii8+Cgk8L2c+CjwvZz4KPGc+Cgk8Zz4KCQk8cGF0aCBkPSJNNDM3LjM5Niw3NC42MDNDMzg5LjI4OCwyNi40OTQsMzI1LjIyLDAsMjU3LjAwNiwwQzI0OC43MTEsMCwyNDIsNi43MTIsMjQyLDE1LjAwNnM2LjcxMiwxNS4wMDYsMTUuMDA2LDE1LjAwNiAgICBjNjAuMTk5LDAsMTE2LjczNCwyMy4zNzMsMTU5LjE3Miw2NS44MTFjNDIuNDM4LDQyLjQzOCw2NS44MTEsOTguOTcyLDY1LjgxMSwxNTkuMTcxYzAsOC4yOTQsNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDYgICAgczE1LjAwNi02LjcxMiwxNS4wMDUtMTUuMDA2QzUxMS45OTksMTg2Ljc4LDQ4NS41MDQsMTIyLjcxMiw0MzcuMzk2LDc0LjYwM3oiIGZpbGw9IiNEODAwMjciLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0zOTUuMzQ0LDExNy4yNTVjLTM2Ljc4Mi0zNi43OTYtODUuNzcxLTU3LjA2My0xMzcuOTM4LTU3LjA2M2MtOC4yOTQsMC0xNS4wMDYsNi43MTItMTUuMDA2LDE1LjAwNiAgICBzNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDZjNDQuMTUzLDAsODUuNjA4LDE3LjE0NiwxMTYuNzE5LDQ4LjI3YzMxLjEyNSwzMS4xMTEsNDguMjcsNzIuNTY3LDQ4LjI3LDExNi43MTkgICAgYzAsOC4yOTQsNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDZjOC4yOTQsMCwxNS4wMDYtNi43MTIsMTUuMDA2LTE1LjAwNkM0NTIuNDA3LDIwMy4wMjUsNDMyLjE0LDE1NC4wMzcsMzk1LjM0NCwxMTcuMjU1eiIgZmlsbD0iI0Q4MDAyNyIvPgoJPC9nPgo8L2c+CjxnPgoJPGc+CgkJPHBhdGggZD0iTTM1Mi45MDYsMTU5LjY5M2MtMjUuNDg0LTI1LjQ5OC01OS40MDgtMzkuNTUxLTk1LjUtMzkuNTUxYy04LjI5NCwwLTE1LjAwNiw2LjcxMi0xNS4wMDYsMTUuMDA2ICAgIGMwLDguMjk0LDYuNzEyLDE1LjAwNiwxNS4wMDYsMTUuMDA2YzI4LjA3NywwLDU0LjQ1NSwxMC45MTcsNzQuMjgxLDMwLjc1OWMxOS44NDEsMTkuODI3LDMwLjc1OSw0Ni4yMDUsMzAuNzU5LDc0LjI4MSAgICBjMCw4LjI5NCw2LjcxMiwxNS4wMDYsMTUuMDA2LDE1LjAwNnMxNS4wMDYtNi43MTIsMTUuMDA2LTE1LjAwNkMzOTIuNDU3LDIxOS4xMDEsMzc4LjQwNCwxODUuMTc3LDM1Mi45MDYsMTU5LjY5M3oiIGZpbGw9IiNEODAwMjciLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0yMTAuNjY1LDEwMi40NThsLTYzLjY2NC02My42NjRjLTE3LjU1Mi0xNy41NTQtNDYuMTEtMTcuNTU0LTYzLjY2MiwwTDcyLjcyNyw0OS40MDVsMTI3LjMyNiwxMjcuMzI2bDEwLjYxMi0xMC42MTEgICAgQzIyOC4yMTksMTQ4LjU2OCwyMjguMjE5LDEyMC4wMDksMjEwLjY2NSwxMDIuNDU4eiIgZmlsbD0iI0Q4MDAyNyIvPgoJPC9nPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=\" height=\"16\" />  <b>{0}</b>: {1}")
Chat.Template("policenineoneone", "<img src=\"data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA1MTEuOTk5IDUxMS45OTkiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMS45OTkgNTExLjk5OTsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIxNnB4IiBoZWlnaHQ9IjE2cHgiPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0zMTEuMjkzLDMzMi42MTNjLTE2LjcyLDcuOTI4LTM3LjI4NSw1LjE1OC01MS4xLTguNjU3bC03Mi4xNDktNzIuMTVjLTEzLjgxNS0xMy44MTUtMTYuNTg2LTM0LjM3OC04LjY1Ny01MS4wOTggICAgTDUwLjEwNiw3MS40MjZMMzkuNDk0LDgyLjAzNWMtNTIuNjU5LDUyLjY2MS01Mi42NTksMTM4LjMzMSwwLDE5MC45OTJsMTk5LjQ3OCwxOTkuNDc4YzUyLjY1OSw1Mi42NTksMTM4LjMzMSw1Mi42NTksMTkwLjk5MSwwICAgIGwxMC42MTEtMTAuNjExTDMxMS4yOTMsMzMyLjYxM3oiIGZpbGw9IiMwYzI1NWMiLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik00NzMuODA3LDM2NS41OThsLTYzLjY2NC02My42NjJjLTE3LjU1NC0xNy41NTQtNDYuMTEtMTcuNTU0LTYzLjY2NCwwbC0xMC42MDksMTAuNjA5bDEyNy4zMjYsMTI3LjMyOGwxMC42MTEtMTAuNjExICAgIEM0OTEuMzYsNDExLjcwOCw0OTEuMzYsMzgzLjE1MSw0NzMuODA3LDM2NS41OTh6IiBmaWxsPSIjMGMyNTVjIi8+Cgk8L2c+CjwvZz4KPGc+Cgk8Zz4KCQk8cGF0aCBkPSJNNDM3LjM5Niw3NC42MDNDMzg5LjI4OCwyNi40OTQsMzI1LjIyLDAsMjU3LjAwNiwwQzI0OC43MTEsMCwyNDIsNi43MTIsMjQyLDE1LjAwNnM2LjcxMiwxNS4wMDYsMTUuMDA2LDE1LjAwNiAgICBjNjAuMTk5LDAsMTE2LjczNCwyMy4zNzMsMTU5LjE3Miw2NS44MTFjNDIuNDM4LDQyLjQzOCw2NS44MTEsOTguOTcyLDY1LjgxMSwxNTkuMTcxYzAsOC4yOTQsNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDYgICAgczE1LjAwNi02LjcxMiwxNS4wMDUtMTUuMDA2QzUxMS45OTksMTg2Ljc4LDQ4NS41MDQsMTIyLjcxMiw0MzcuMzk2LDc0LjYwM3oiIGZpbGw9IiMwYzI1NWMiLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0zOTUuMzQ0LDExNy4yNTVjLTM2Ljc4Mi0zNi43OTYtODUuNzcxLTU3LjA2My0xMzcuOTM4LTU3LjA2M2MtOC4yOTQsMC0xNS4wMDYsNi43MTItMTUuMDA2LDE1LjAwNiAgICBzNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDZjNDQuMTUzLDAsODUuNjA4LDE3LjE0NiwxMTYuNzE5LDQ4LjI3YzMxLjEyNSwzMS4xMTEsNDguMjcsNzIuNTY3LDQ4LjI3LDExNi43MTkgICAgYzAsOC4yOTQsNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDZjOC4yOTQsMCwxNS4wMDYtNi43MTIsMTUuMDA2LTE1LjAwNkM0NTIuNDA3LDIwMy4wMjUsNDMyLjE0LDE1NC4wMzcsMzk1LjM0NCwxMTcuMjU1eiIgZmlsbD0iIzBjMjU1YyIvPgoJPC9nPgo8L2c+CjxnPgoJPGc+CgkJPHBhdGggZD0iTTM1Mi45MDYsMTU5LjY5M2MtMjUuNDg0LTI1LjQ5OC01OS40MDgtMzkuNTUxLTk1LjUtMzkuNTUxYy04LjI5NCwwLTE1LjAwNiw2LjcxMi0xNS4wMDYsMTUuMDA2ICAgIGMwLDguMjk0LDYuNzEyLDE1LjAwNiwxNS4wMDYsMTUuMDA2YzI4LjA3NywwLDU0LjQ1NSwxMC45MTcsNzQuMjgxLDMwLjc1OWMxOS44NDEsMTkuODI3LDMwLjc1OSw0Ni4yMDUsMzAuNzU5LDc0LjI4MSAgICBjMCw4LjI5NCw2LjcxMiwxNS4wMDYsMTUuMDA2LDE1LjAwNnMxNS4wMDYtNi43MTIsMTUuMDA2LTE1LjAwNkMzOTIuNDU3LDIxOS4xMDEsMzc4LjQwNCwxODUuMTc3LDM1Mi45MDYsMTU5LjY5M3oiIGZpbGw9IiMwYzI1NWMiLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0yMTAuNjY1LDEwMi40NThsLTYzLjY2NC02My42NjRjLTE3LjU1Mi0xNy41NTQtNDYuMTEtMTcuNTU0LTYzLjY2MiwwTDcyLjcyNyw0OS40MDVsMTI3LjMyNiwxMjcuMzI2bDEwLjYxMi0xMC42MTEgICAgQzIyOC4yMTksMTQ4LjU2OCwyMjguMjE5LDEyMC4wMDksMjEwLjY2NSwxMDIuNDU4eiIgZmlsbD0iIzBjMjU1YyIvPgoJPC9nPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=\" height=\"16\" />  <b>{0}</b>: {1}")
Chat.Template("policedispatch", "<img src=\"data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA0NTkuNjY4IDQ1OS42NjgiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDQ1OS42NjggNDU5LjY2ODsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIxNnB4IiBoZWlnaHQ9IjE2cHgiPgo8ZyBpZD0iWE1MSURfMl8iPgoJPGc+CgkJPGc+CgkJCTxwYXRoIGQ9Ik0zNTkuNTc0LDI5Ny4wNDNjLTE4LjIwNCwyNS4wMDItNDcuNjkyLDQxLjI4Ni04MC45MTYsNDEuMjg2aC00Ni42MThjLTE2LjEwNCwwLTI5LjgxOC0xMC4yMjQtMzUuMDExLTI0LjUzNCAgICAgYy02LjQxLTEuOTEyLTEyLjY5Ni00LjM5NC0xOC44My03LjQ0MmMtMTIuOTktNi40NTQtMjQuNzg1LTE1LjE5OC0zNS4xNjgtMjYuMDNjLTY3LjM1LDE0Ljc5Ni0xMTcuNzU3LDc0LjgwOC0xMTcuNzU3LDE0Ni42MDMgICAgIHY5LjM4NGMwLDEyLjksMTAuNDU4LDIzLjM1OCwyMy4zNTgsMjMuMzU4aDM2Mi40MDNjMTIuOSwwLDIzLjM1OC0xMC40NTgsMjMuMzU4LTIzLjM1OHYtOS4zODQgICAgIEM0MzQuMzkyLDM3MS40NjQsNDA0LjMwOSwzMjMuMDMyLDM1OS41NzQsMjk3LjA0M3oiIGZpbGw9IiMxNDc1YmEiLz4KCQkJPHBhdGggZD0iTTExOC4yMDUsMjMyLjE3OGMxMC4wMzksMCwxOC43NzctNS41NjQsMjMuMzA0LTEzLjc3NWMwLjExOSwwLjMyNSwwLjI0LDAuNjQ4LDAuMzYyLDAuOTcxICAgICBjMC4wMzYsMC4wOTcsMC4wNzIsMC4xOTQsMC4xMDgsMC4yOTFjMTAuNjIsMjcuOTU0LDMxLjI4NCw1MS4zODgsNTguNTMyLDYxLjYyN2M2LjU5LTEwLjQ3MSwxOC4yNDMtMTcuNDM1LDMxLjUzLTE3LjQzNWg0Ni42MTggICAgIGM0LjY1LDAsOC45NzgtMS4zMTIsMTIuNzcyLTMuNDMzYzYuMzcyLTMuNTYzLDEyLjEwMi0xMi42MDIsMTUuMDYxLTE3LjM5M2M0LjczNS03LjY2Nyw4LjQwNC0xNS43ODgsMTEuNjU3LTI0LjY0MiAgICAgYzEuODI4LDMuMzIsNC4zNDIsNi4yMDgsNy4zNTQsOC40NzF2MTEuNDMxYzAsMjUuODMtMjEuMDE0LDQ2Ljg0NS00Ni44NDUsNDYuODQ1SDIzMi4wNGMtOC44MTMsMC0xNS45NTgsNy4xNDUtMTUuOTU4LDE1Ljk1OCAgICAgYzAsOC44MTQsNy4xNDUsMTUuOTU4LDE1Ljk1OCwxNS45NThoNDYuNjE4YzQzLjQyOSwwLDc4Ljc2MS0zNS4zMzIsNzguNzYxLTc4Ljc2MVYyMjYuODYgICAgIGM2LjQ2LTQuODUzLDEwLjYzOS0xMi41NzcsMTAuNjM5LTIxLjI3OHYtNDguMTE5di0xOC40NTJjMC04Ljg4LTQuMzU1LTE2LjczNy0xMS4wNDItMjEuNTY4QzM1MS44Myw1MS44MTYsMjk2Ljc3LDAsMjI5LjgzMywwICAgICBDMTYyLjg5NSwwLDEwNy44MzYsNTEuODE2LDEwMi42NSwxMTcuNDQyYy02LjY4Nyw0LjgzMS0xMS4wNDIsMTIuNjg5LTExLjA0MiwyMS41Njh2NjYuNTcgICAgIEM5MS42MDgsMjIwLjMxMSwxMDMuNTc1LDIzMi4xNzgsMTE4LjIwNSwyMzIuMTc4eiBNMjI5LjgzMywzMS45MTdjNDkuNTUyLDAsOTAuNDIzLDM3Ljg2OCw5NS4yLDg2LjE4NSAgICAgYy0zLjEzNiwyLjQ2Ny01LjcwNSw1LjYyLTcuNDc1LDkuMjM4Yy0xNS4wNTgtMzkuMjg2LTQ4LjY3Mi02Ni42MzgtODcuNzI2LTY2LjYzOGMtMzkuODk2LDAtNzIuOTcxLDI4LjI5Mi04Ny42NjcsNjYuNDgxICAgICBjLTAuMDIsMC4wNTItMC4wMzksMC4xMDUtMC4wNTksMC4xNThjLTEuNzctMy42MTgtNC4zMzktNi43NzEtNy40NzUtOS4yMzhDMTM5LjQxMSw2OS43ODUsMTgwLjI4MSwzMS45MTcsMjI5LjgzMywzMS45MTd6IiBmaWxsPSIjMTQ3NWJhIi8+CgkJPC9nPgoJPC9nPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=\" height=\"16\" />  <b>{0}</b>: {1}")

RegisterServerEvent('paramedic:setService')
AddEventHandler('paramedic:setService', function (inService)
	local source = source
	if inService and not emergency_users[source] then
		emergency_users[source] = "paramedic"
	elseif not inService and emergency_users[source] then
		emergency_users[source] = nil
	end
end)

RegisterServerEvent('police:setService')
AddEventHandler('police:setService', function (inService)
	local source = source
	if inService and not emergency_users[source] then
		emergency_users[source] = "cop"
	elseif not inService and emergency_users[source] then
		emergency_users[source] = nil
	end
end)

AddEventHandler("playerDropped", function()
	local source = source
	if emergency_users[source] then
		emergency_users[source] = nil
	end
end)

AddEventHandler("core:switch", function(source)
	local source = source
	if emergency_users[source] then
		emergency_users[source] = nil
	end
end)

Chat.Command("311", function(source, args, rawCommand)
	local Message = table.concat(args, " ")
	TriggerEvent("phone:has", source, function(hasphone)
		if hasphone then
			if Message ~= "" then
				for id, dept in pairs(emergency_users) do
					if id ~= source then
						if dept ~= nil then
							Chat.Message(id, "311 - ^5[^3"..source.."^5]^r", Message, 255, 255, 0, true, "policethreeoneone")
							TriggerClientEvent("dispatch:311", id, source, Message)
							TriggerClientEvent("trigger:animation", source)
						end
					end
				end
				Chat.Message(source, "311 - ^5[^3"..source.."^5]^r", Message, 255, 255, 0, true, "policethreeoneone")
				TriggerClientEvent("trigger:animation", source)
			end
		else
			Chat.Message(source, "You dont have a phone right? How can you call emergency services", 255, 255, 255, true)
		end
	end)
end, false, {Help = "Call for assistance(Non-Emergency)", Params = {{name = "message", help = "Message to send to the emergency services"}}})

Chat.Command("911", function(source, args, rawCommand)
	local Message = table.concat(args, " ")
	TriggerEvent("phone:has", source, function(hasphone)
		if hasphone then
			if Message ~= "" then
				for id, dept in pairs(emergency_users) do
					if id ~= source then
						if dept ~= nil then
							Chat.Message(id, "911 - ^5[^3"..source.."^5]^r", Message, 255, 0, 0, true, "policenineoneone")
							TriggerClientEvent("dispatch:911", id, source, Message)
						end
					end
				end
				Chat.Message(source, "911 - ^5[^3"..source.."^5]^r", Message, 255, 0, 0, true, "policenineoneone")
				TriggerClientEvent("trigger:animation", source)
			end
		else
			Chat.Message(source, "You dont have a phone right? How can you call emergency services", 255, 255, 255, true)
		end
	end)
end, false, {Help = "Call for assistance(Emergency)", Params = {{name = "message", help = "Message to send to the emergency services"}}})

Chat.Command("dispatch", function(source, args, rawCommand)
	if emergency_users[source] then
		if args[2] then
			local Target, Message = args[1], table.concat(args, " ", 2)
			if GetPlayerName(Target) ~= nil then
	        	Chat.Message(Target, "^*Dispatch: ^r", Message, 0, 255, 0, true, "policedispatch")
				for id, dept in pairs(emergency_users) do
					Chat.Message(id, "^*Dispatch:^r ", "Sent \"^3"..Message.."^r\" to caller ^2"..Target.."^r.", 0, 255, 0, true, "policedispatch")
				end
	        else
	        	Chat.Message(source, "^*Dispatch:^r ", "Unable to reach caller ^2"..Target.."^r.", 0, 255, 0, true, "policedispatch")
	        end
	    end
	else
		Chat.Message(source, "^*Dispatch:^r ", "^3^*^_You do not have permission to use this command.", 0, 255, 0, true, "policedispatch")
	end
end, false, {Help = "Respond back towards a call.", Params = {{name = "id", help = "The caller ID"}, {name = "message", help = "Message to send to the caller"}}})

RegisterServerEvent("dispatch:panic.button")
AddEventHandler("dispatch:panic.button", function(Message)
	local source = source
	for id, dept in pairs(emergency_users) do
		if dept ~= nil then
			Chat.Message(id, "10-13", Message, 255, 0, 0, true, "panic")
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirteen")
AddEventHandler("dispatch:ten-thirteen", function(street_name)
	local source = source
	for id, dept in pairs(emergency_users) do
		if dept ~= nil then
			TriggerClientEvent("chatMessage", id, "10-13", {255, 0, 0}, "^7Officer down at "..street_name)
			TriggerClientEvent("dispatch:add_ten-thirteen", id, source)
		end
	end
end)

--[[RegisterServerEvent("dispatch:panicbutton")
AddEventHandler("dispatch:panicbutton", function(street_name)
	local source = source
	for id, dept in pairs(emergency_users) do
		if dept ~= nil then
			TriggerClientEvent("chatMessage", id, "Panic Button", {255, 0, 0}, "^7Officer in distress at "..street_name)
			TriggerClientEvent("dispatch:add_panic-button", id, source)
		end
	end
end)--]]

RegisterServerEvent("dispatch:ten-thirtytwo")
AddEventHandler("dispatch:ten-thirtytwo", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-32", {255, 0, 0}, "^7Shots fired at "..street_name)
			TriggerClientEvent("dispatch:ten-thirtytwo", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirtyone")
AddEventHandler("dispatch:ten-thirtyone", function(coords, street_name, model, plate)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-31", {255, 0, 0}, "^7Grand theft auto reported at "..street_name..". Car is a "..model.." with plate "..plate)
			TriggerClientEvent("dispatch:ten-thirtyone", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirtyone_2")
AddEventHandler("dispatch:ten-thirtyone_2", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-31", {255, 0, 0}, "^7Possible break-in reported at "..street_name)
			TriggerClientEvent("dispatch:ten-thirtyone_2", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-fifthteen")
AddEventHandler("dispatch:ten-fifthteen", function(coords, street_name, gender)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-15", {255, 0, 0}, "^7Suspicious "..gender.." dealing drugs was reported at "..street_name)
			TriggerClientEvent("dispatch:ten-fifthteen", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-ninety")
AddEventHandler("dispatch:ten-ninety", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-90", {255, 0, 0}, "^7A silent alarm has been triggered on "..street_name)
			TriggerClientEvent("dispatch:ten-ninety", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:pay")
AddEventHandler("dispatch:pay", function(type)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "^4You have been paid $"..pay[type].." for responding to the "..type)
		user.addWallet(pay[type])
	end)
end)

RegisterServerEvent("dispatch:notify-cops")
AddEventHandler("dispatch:notify-cops", function(message)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "Dispatch", {0, 255, 0}, "^7"..message)
		end
	end
end)