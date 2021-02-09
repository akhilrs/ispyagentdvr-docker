group "default" {
	targets = ["latest", "3.1.3.0"]
}
target "common" {
	platforms = ["linux/amd64", "linux/arm64"]
	args = {"FILE_LOCATION" = "https://ispyfiles.azureedge.net/downloads/Agent_Linux64_3_1_3_0.zip", "DEFAULT_FILE_LOCATION" = "https://www.ispyconnect.com/api/Agent/DownloadLocation2?productID=24&is64=true&platform=Linux", "TZ" = "Asia/Kolkata"}
}
target "main" {
	inherits = ["common"]
	dockerfile = "Dockerfile"
}
