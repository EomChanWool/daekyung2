package apc.sl.basicInfo.actualResult.web;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import apc.sl.basicInfo.actualResult.service.ActualResultService;
import apc.util.SHA256;
import apc.util.Scheduler;
import apc.util.SearchVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ActualResultController {
	@Autowired
	private ActualResultService actualResultService;
	@Autowired
	private SHA256 sha256;
	@Resource
	private Properties fileProperties;
	
	@RequestMapping("/sl/login.do")
	public String login(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		
		Map<String, Object> member = actualResultService.selectActualResult(map);
		
		
		
		if(member == null) {
			redirectAttributes.addFlashAttribute("msg", "아이디가없습니다");
			return "redirect:/sl/main.do";
		} else {
			if(!sha256.encrypt(map.get("password")+"").equals(member.get("miPass")+"")) {
				redirectAttributes.addFlashAttribute("member",member);
				redirectAttributes.addFlashAttribute("msg", "비밀번호불일치");
				return "redirect:/sl/main.do";
			}
		}
		//로그인 성공시 세션값 부여
		session.setAttribute("memberVO", member);
		session.setAttribute("user_id", member.get("miId"));
		
		
		
		session.setMaxInactiveInterval(0);
		//시스템로그 기록
		member.put("ip", getUserIp());
		member.put("comment", "로그인");
		actualResultService.insertSystemLog(member);
		
//		메뉴 권한 목록
//		List<?> miLevel = actualResultService.selectMenuLevel();
//		Map<String, Object> miLev = new HashMap<>();
//		for(int i=0;i<miLevel.size();i++) {
//			String[] temp = miLevel.get(i).toString().split(", ");
//			temp[1] = temp[1].replace("}", "");
//			String[] str1 = temp[0].split("=");
//			String[] str2 = temp[1].split("=");
//			miLev.put(str1[1], str2[1]);
//		}
//		session.setAttribute("miLevel", miLev);
		if(Integer.parseInt(member.get("miLevel")+"") == 4) {
			Date now = new Date();
			SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
			
			String now2 = format.format(now);
			int dataVal = 100 + (int) (Math.random() * 301);
			
			redirectAttributes.addFlashAttribute("API", "API");
			redirectAttributes.addFlashAttribute("APIIP", getUserIp());
			redirectAttributes.addFlashAttribute("APIID", member.get("miId"));
			redirectAttributes.addFlashAttribute("APINOTE", "접속");
			redirectAttributes.addFlashAttribute("APITIME", now2);
			redirectAttributes.addFlashAttribute("APIDATA", dataVal);
			return "redirect:/sl/basicInfo/user/userList.do";
		}else if(Integer.parseInt(member.get("miLevel")+"") < 4 && Integer.parseInt(member.get("miLevel")+"") > 1) {
			
			return "redirect:/sl/basicInfo/prodInfo/prodInfoList.do";
		}
		else {
			if(member.get("miId").equals("pop1")) {
				return "redirect:/sl/pop/popMf/popMfList.do";
			}
			if(member.get("miId").equals("pop2")) {
				return "redirect:/sl/pop/popMf/popMfList.do";
			}
			return "redirect:/sl/basicInfo/materialMove/materialMoveList.do";
		}
		
		
		
		
	}
	
	@RequestMapping("/sl/logout.do")
	public String logout(@RequestParam Map<String,Object> info, RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("memberVO");
		Date now = new Date();
		SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		
		String now2 = format.format(now);
		//시스템로그 기록
		Map<String, Object> log = (Map<String, Object>) session.getAttribute("memberVO");
		log.put("ip", getUserIp());
		log.put("comment","로그아웃");
		actualResultService.insertSystemLog(log);
		
		if(obj != null) {
			session.removeAttribute("memberVO");
			session.removeAttribute("user_id");
		}
		
		redirectAttributes.addFlashAttribute("msg", "로그아웃되었습니다");
		redirectAttributes.addFlashAttribute("APIID",  session.getAttribute("user_id"));
		redirectAttributes.addFlashAttribute("API", "API");
		redirectAttributes.addFlashAttribute("APIIP", getUserIp());
		
		redirectAttributes.addFlashAttribute("APINOTE", "종료");
		redirectAttributes.addFlashAttribute("APITIME", now2);
		return "redirect:/sl/main.do";
	}
	
	@RequestMapping("/sl/basicInfo/actualResult/actualResultList.do")
	public String actualResultList(@ModelAttribute("searchVO") SearchVO searchVO, ModelMap model, HttpSession session) {
		int totCnt = actualResultService.selectActualResultListToCnt(searchVO);
		/** pageing setting */
		searchVO.setPageSize(10);
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex()); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(searchVO.getPageSize()); // 페이징 리스트의 사이즈
		paginationInfo.setTotalRecordCount(totCnt);
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		List<?> actualResultList = actualResultService.selectActualResultList(searchVO);
		model.put("actualResultList", actualResultList);
		model.put("paginationInfo", paginationInfo);
		return "sl/basicInfo/actualResult/actualResultList";
	}
	
	@RequestMapping("/sl/basicInfo/member/registMember.do")
	public String registMember() {
		return "sl/basicInfo/member/memberRegist";
	}
	
	@RequestMapping(value="/sl/basicInfo/member/idChkAjax.do", method = RequestMethod.POST)
	public ModelAndView selectidChkAjax(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		String exists = actualResultService.selectId(map);
		mav.setViewName("jsonView");
		mav.addObject("id",exists);
		return mav;
	}
	
	
	@RequestMapping(value="/sl/basicInfo/goal/selectApi.do")
	@ResponseBody
	public ModelAndView selectApi() {
		
		ModelAndView mav = new ModelAndView();
		Map<String,Object> newMap = new HashMap<>();
		Date now = new Date();
		SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		
		String now2 = format.format(now);
		
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        
        Random random = new Random();
        boolean result = random.nextBoolean();
        
        System.out.println(now + " : " + result);
       
        if (hour >= 9 && hour < 17 && dayOfWeek > 1) {
        	String [] ipList = {"192.168.0.251","192.168.0.12","192.168.0.61","192.168.0.250"};
    		
    		int ranIp = (int) (Math.random()*ipList.length);
    		
    		String cIp = ipList[ranIp];
    		
    		String [] memList = {"admin","dkkim","pop1","pop2"};
    		
    		int memIndex = (int) (Math.random()*memList.length);
    		
    		int dataVal = 100 + (int) (Math.random() * 301);

			/*
			 * List<?> memList = actualResultService.memList(); int memIndex = (int)
			 * (Math.random()* memList.size()); Map<String,Object> memIdMap = (Map<String,
			 * Object>) memList.get(memIndex);
			 */
    		
    		String memId = memList[memIndex];
    		
    		 
    		
    		
    		
    		newMap.put("logDt", now2);
    		newMap.put("useSe","접속");
    		newMap.put("sysUser", memId);
    		newMap.put("conectIp",cIp);
    		newMap.put("dataVal",dataVal);
    		
    		Map<String, Object> dataMap = new HashMap<String, Object>();
    		dataMap.put("miId", memId);
    		dataMap.put("ip",cIp);
    		dataMap.put("comment", "로그인");
    		if(result) {
    		actualResultService.insertSystemLog(dataMap);}
    		
    		mav.setViewName("jsonView");
    		mav.addObject("res",newMap);
    		mav.addObject("tr",result);
    		return mav;
        } else {
        	result = false;
        	mav.setViewName("jsonView");
        	mav.addObject("tr", result);
            return mav;
        }
		
		
	}
	
	@RequestMapping("/sl/basicInfo/member/registMemberOk.do")
	public String registMemberOk(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes, HttpSession session) throws Exception {
		String pwd = sha256.encrypt(map.get("mPwd").toString());
		map.put("mPwd", pwd);
		actualResultService.registMemberOk(map);
		redirectAttributes.addFlashAttribute("msg","등록 되었습니다.");
		return "redirect:/sl/basicInfo/member/memberList.do";
	}
	
	@RequestMapping("/sl/basicInfo/member/modifyMember.do")
	public String modifyMember(@RequestParam Map<String, Object> map, ModelMap model) {
		Map<String, Object> detail = actualResultService.selectMemberInfo(map);
		model.put("memberVO", detail);
		return "sl/basicInfo/member/memberModify";
	}
	
	@RequestMapping("/sl/basicInfo/member/modifyMemberOk.do")
	public String modifyMemberOk(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes, HttpSession session) throws Exception {
		String pwd = sha256.encrypt(map.get("mPwd").toString());
		map.put("mPwd", pwd);
		actualResultService.modifyMember(map);
		redirectAttributes.addFlashAttribute("msg","수정 되었습니다.");
		return "redirect:/sl/basicInfo/member/memberList.do";
	}
	
	@RequestMapping("/sl/basicInfo/member/deleteMember.do")
	public String deleteMember(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes) {
		actualResultService.deleteMember(map);
		redirectAttributes.addFlashAttribute("msg","삭제 되었습니다.");
		return "redirect:/sl/basicInfo/member/memberList.do";
	}
	
	public String getUserIp() throws Exception {
		String ip = null;
        HttpServletRequest request = 
        ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

        ip = request.getHeader("X-Forwarded-For");
        
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("WL-Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_CLIENT_IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-Real-IP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-RealIP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getRemoteAddr(); 
        }
        if(ip.equals("0:0:0:0:0:0:0:1") || ip.equals("127.0.0.1")) {
        	InetAddress address = InetAddress.getLocalHost();
        	ip = address.getHostAddress();
        }
		return ip;
	}
}
