package org.csm.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.csm.domain.MemberVO;
import org.csm.mapper.MemberMapper;
import org.csm.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		// loadUserByUsername()은 내부적으로 MemberMapper를 이용해서 MemberVO를 조회하고, 만일 MemberVO의 인스턴스를 얻을 수 있다면 CustomUser 타입의 객체로
		// 변환해서 변환한다. 로그인시 CustomUserDetailsService가 동작하는 모습을 확인할 수 있다.
		log.warn("Load User By UserName : " + userName);

		// userName means userid
		MemberVO vo = memberMapper.read(userName);

		log.warn("queried by member mapper: " + vo);

		return vo == null ? null : new CustomUser(vo);
	} 

}
