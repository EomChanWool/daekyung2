package apc.util;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.text.SimpleDateFormat;
import java.util.*;

@Component
public class LogDataScheduler {

    private final RestTemplate restTemplate = new RestTemplate();

    @Scheduled(fixedRate = 68500 * 60) // 68.5분 (밀리초 단위)
    public void sendLogData() {
        // 현재 시간 생성
        Date now = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        String now2 = format.format(now);

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);

        Random random = new Random();
        boolean result = random.nextBoolean();

        System.out.println(now + " : " + result);

        if (hour >= 9 && hour < 18 && dayOfWeek > 1) { // 9~17시 사이, 월~금
            String[] ipList = {"192.168.0.251", "192.168.0.12", "192.168.0.61", "192.168.0.250"};
            int ranIp = random.nextInt(ipList.length);

            String[] memList = {"admin", "dkkim", "pop1", "pop2"};
            int memIndex = random.nextInt(memList.length);

            int dataVal = 100 + random.nextInt(301); // 100~400 범위

            String cIp = ipList[ranIp];
            String memId = memList[memIndex];

            // 전송 데이터 구성
            Map<String, Object> param = new HashMap<>();
            param.put("crtfcKey", "$5$API$/HjxvBFQc5Kbx7GK1o1nvZnhcCiFTnnxlUsTz5FWRg5");
            param.put("logDt", now2);
            param.put("useSe", "접속");
            param.put("sysUser", memId);
            param.put("conectIp", cIp);
            param.put("dataUsgqty", dataVal);

            try {
                // API 호출
                String apiUrl = "https://log.smart-factory.kr/apisvc/sendLogData.json";
                Map<String, Object> response = restTemplate.postForObject(apiUrl, param, Map.class);

                System.out.println("전송 성공: " + response);
            } catch (Exception e) {
                System.err.println("전송 실패: " + e.getMessage());
            }
        } else {
            System.out.println("조건 불충족: 데이터 전송 생략");
        }
    }
}
