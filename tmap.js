 //좌표 값을 통해 신 주소 값을 리턴
function reverseGeo(x, y) {
    var newRoadAddr;
    $.ajax({
        method: "GET",
        url: "https://apis.openapi.sk.com/tmap/geo/reversegeocoding?version=1&format=json&callback=result",
        async: false,
        data: {
            "appKey": "l7xx34fbc458caac49f6b3fd63b8e1dcadd5",
            "coordType": "WGS84GEO",
            "addressType": "A10",
            "lon": x, //위도
            "lat": y //경도
        },
        success: function (response) {
            // 3. json에서 주소 파싱
            var arrResult = response.addressInfo;

            //법정동 마지막 문자 
            var lastLegal = arrResult.legalDong.charAt(arrResult.legalDong.length - 1);

            // 새주소
            newRoadAddr = arrResult.city_do + ' ' + arrResult.gu_gun + ' ';

            if (arrResult.eup_myun == ''
                && (lastLegal == "읍" || lastLegal == "면")) {//읍면
                newRoadAddr += arrResult.legalDong;
            } else {
                newRoadAddr += arrResult.eup_myun;
            }
            newRoadAddr += ' ' + arrResult.roadName + ' '
                + arrResult.buildingIndex;

            // 새주소 법정동& 건물명 체크
            if (arrResult.legalDong != ''
                && (lastLegal != "읍" && lastLegal != "면")) {//법정동과 읍면이 같은 경우

                if (arrResult.buildingName != '') {//빌딩명 존재하는 경우
                    newRoadAddr += (' (' + arrResult.legalDong
                        + ', ' + arrResult.buildingName + ') ');
                } else {
                    newRoadAddr += (' (' + arrResult.legalDong + ')');
                }
            } else if (arrResult.buildingName != '') {//빌딩명만 존재하는 경우
                newRoadAddr += (' (' + arrResult.buildingName + ') ');
            }
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n"
                + "message:" + request.responseText + "\n"
                + "error:" + error);
        }
    });
    return newRoadAddr;
}

// 주소를 통하여 좌표값을 반환
function toPoint(str){
    var x;
    var y;
    $.ajax({
        method: "GET",
        url: "https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result",
        async: false,
        data: {
            "appKey": "l7xx34fbc458caac49f6b3fd63b8e1dcadd5",
            "searchKeyword": str,
            "resCoordType": "EPSG3857",
            "reqCoordType": "WGS84GEO",
            "count": 1
        },
        success: function (response) {
            var resultpoisData = response.searchPoiInfo.pois.poi;

            var positionBounds = new Tmapv2.LatLngBounds();	//맵에 결과물 확인 하기 위한 LatLngBounds객체 생성    
            var noorLat = Number(resultpoisData[0].noorLat); // 좌표의 경도
            var noorLon = Number(resultpoisData[0].noorLon); // 좌표의 위도

            var pointCng = new Tmapv2.Point(noorLon, noorLat);
            var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);

            y = projectionCng._lat;
            x = projectionCng._lng;
           
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });

    return [x, y];
}