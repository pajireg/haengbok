<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <!-- Footer -->
  <footer class="footer">
    <div class="container">
      <p class="m-0 text-center" style="color:#6c757d">Copyright &copy; Your Website 2019</p>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  
  <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document" style="top:30%">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">현재 세션을 종료 할 준비가되면 아래의 "로그 아웃"을 선택하십시오.</div>
        <div class="modal-footer">
          <form action="/haengbok/member/logout" method='post'>
			<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
          <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
          <input type="submit" class="btn btn-primary" value="로그아웃">
          </form>
        </div>
      </div>
    </div>
  </div>

</body>

</html>