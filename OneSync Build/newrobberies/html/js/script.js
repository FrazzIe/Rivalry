const CameraApp = new Vue({
    el: "#Camera_Container",

    data: {
        camerasOpen: false,
        cameraBoxLabel: "Testing",
        cameraLabel: "Front Left Store Camera",
        cameraTime: null
    },

    methods: {
        OpenCameras(boxLabel, label) {
            $("#body").show();
            this.camerasOpen = true;
            this.cameraLabel = label;
            this.cameraBoxLabel =  boxLabel;
        },

        CloseCameras() {
            $("#body").hide();
            this.camerasOpen = false;
        },

        UpdateCameraLabel(boxLabel, label) {
            this.cameraLabel = label;
            this.cameraBoxLabel = boxLabel;
        },

        UpdateTime(time) {
            this.cameraTime = time;
        }
    }
});

document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        $("#body").hide();

        function updateClock() {
            var time = new Date();
            hour = ('0'+time.getHours()).slice(-2);
            minute = ('0'+time.getMinutes()).slice(-2);
            second = ('0'+time.getSeconds()).slice(-2);
            var currentTime = hour + ":" + minute + ":" + second;
            CameraApp.UpdateTime(currentTime);
        }
        setInterval(updateClock, 1000);

        window.addEventListener('message', function(event) {

            if (event.data.type == "enablecam") {
                
                CameraApp.OpenCameras(event.data.box, event.data.label);

            } else if (event.data.type == "disablecam") {

                CameraApp.CloseCameras();

            } else if (event.data.type == "updatecam") {

                CameraApp.UpdateCameraLabel(event.data.box, event.data.label);

            }

        });
    };
};