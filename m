Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33F658AD64
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Aug 2022 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiHEPrI (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 5 Aug 2022 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbiHEPpx (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 5 Aug 2022 11:45:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC274E2C
        for <linux-sctp@vger.kernel.org>; Fri,  5 Aug 2022 08:44:46 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z3so2315238qtv.5
        for <linux-sctp@vger.kernel.org>; Fri, 05 Aug 2022 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KRL3uXxEAYwXccTWqFpkhgNCp/cSYUd5DUQChhVB5Ws=;
        b=GuRax/U4sLL4QGU6QqZue724aF4KCRbFeNnUflhC9t2y3Qhw9jDPSb32aluDtjj6Wq
         B40bUS2iQ3hWqDQhMSM67gShqkuodMinmTNYAVxLotUgqKb0Fnfj/gGQj/jYp8Z8BBif
         3udif1SSJhAUG+9FR3NrRMeMM4izh5xStRwbjKyXy62rhgJruzRnQM3WxkSmCQo3xVwq
         aUTVncLHQGs6O41Qxta+zaIPxGx8DmKdVLsPfGmeU547OQt4ZvBG/GTFBiQeRPZw9Z4X
         NrlSYZ7y08TBiVISI8+onkYnHb0jqnatZTuLX1m5Z76jULkb4R5LX5gG43AhfNs1IV6y
         N+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KRL3uXxEAYwXccTWqFpkhgNCp/cSYUd5DUQChhVB5Ws=;
        b=D84wBzQARqxotUYqDP/Rnz5u6yh2aKrlyjD69y27Uiwdx1p8y+tM6k6dJiYMOCNEvQ
         vEMsjWjyd5ARneL0xHQM74k14SkePsl8RQ8jxua3ZIEq+V24qZC3pZ//sOOGUv8umlIs
         g1QHi33wUGqQytQYdCtYmj6UDLzMsbDE9Umyu1WKvueVjdHhPTVFuZ6InBcvEM7WFjKi
         B3kH4+iDYw/swRD4YKquR4QEe2TGJ0C9zH6k3wUW1yEJQy8msnmYYnmUy3axKLwy/u3V
         yL2c2HkgotMrkANwg3boFRsPt5EI81Vm7PYIs8/PTfPaCiVl6D5Rc73SNvfEqmnZHG1g
         cGmA==
X-Gm-Message-State: ACgBeo3Ek8gCtbG2JjK8diMIzQRYE03drWMJw+WE2oEyB7J/1pU719uJ
        VrPRnoQIE5dvHdm4lBPmAs+Fga98uwFu5A==
X-Google-Smtp-Source: AA6agR44ol9ou44Sv5bb7SBHtao9Ft8ZYe/nGnpyF4YpanxJM2nudfWl7QS0RTQ0QdPQEiZLyqFtow==
X-Received: by 2002:ac8:5f07:0:b0:341:10f0:2e4f with SMTP id x7-20020ac85f07000000b0034110f02e4fmr6297431qta.657.1659714285196;
        Fri, 05 Aug 2022 08:44:45 -0700 (PDT)
Received: from cache-fedora.hsd1.nj.comcast.net ([2601:86:200:98b0::c166])
        by smtp.gmail.com with ESMTPSA id x9-20020ac81209000000b0031ef21aec36sm2809153qti.32.2022.08.05.08.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:44:44 -0700 (PDT)
From:   Yuxuan Luo <luoyuxuan.carl@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     marcelo.leitner@gmail.com, lucien.xin@gmail.com, yuluo@redhat.com,
        Yuxuan Luo <luoyuxuan.carl@gmail.com>
Subject: [PATCH lksctp-tools 1/2] Add a test case for interleaving
Date:   Fri,  5 Aug 2022 11:43:52 -0400
Message-Id: <20220805154351.27646-2-luoyuxuan.carl@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805154351.27646-1-luoyuxuan.carl@gmail.com>
References: <20220805154351.27646-1-luoyuxuan.carl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Add a test case for verifying the support for user message interleave
implemented in RFC8260.

This test case will not be built if the SCTP_FRAGMENT_INTERLEAVE
declaration is not present and will skip if net.sctp.intl_enable
is not set to 1.
---
 configure.ac                     |   3 +
 src/func_tests/.gitignore        |   2 +
 src/func_tests/Makefile.am       |  10 ++
 src/func_tests/test_interleave.c | 254 +++++++++++++++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 src/func_tests/test_interleave.c

diff --git a/configure.ac b/configure.ac
index 28132bf..bd0144c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -107,6 +107,9 @@ LKSCTP_CHECK_MEMBER([struct sctp_paddrparams.spp_ipv6_flowlabel],
 LKSCTP_CHECK_MEMBER([struct sctp_paddrparams.spp_dscp],
 		    [HAVE_SCTP_SPP_DSCP])
 
+# RFC 8260 (Message Interleaving)
+LKSCTP_CHECK_DECL([SCTP_FRAGMENT_INTERLEAVE], [HAVE_SCTP_FRAGMENT_INTERLEAVE])
+
 AC_CONFIG_HEADERS([src/include/netinet/sctp.h])
 AC_CONFIG_FILES([lksctp-tools.spec
 		Makefile
diff --git a/src/func_tests/.gitignore b/src/func_tests/.gitignore
index 720db65..4e51a74 100644
--- a/src/func_tests/.gitignore
+++ b/src/func_tests/.gitignore
@@ -28,6 +28,8 @@ test_getname
 test_getname_v6
 test_inaddr_any
 test_inaddr_any_v6
+test_interleave
+test_interleave_v6
 test_peeloff
 test_peeloff_v6
 test_recvmsg
diff --git a/src/func_tests/Makefile.am b/src/func_tests/Makefile.am
index e5bf454..07d9fa4 100644
--- a/src/func_tests/Makefile.am
+++ b/src/func_tests/Makefile.am
@@ -68,6 +68,13 @@ PASSING_V6_KERN_TESTS += \
 	test_sctp_sendvrecvv_v6
 endif
 
+if HAVE_SCTP_FRAGMENT_INTERLEAVE
+PASSING_KERN_TESTS += \
+	test_interleave
+PASSING_V6_KERN_TESTS += \
+	test_interleave_v6
+endif
+
 noinst_PROGRAMS = ${PASSING_KERN_TESTS} ${PASSING_V6_KERN_TESTS}
 
 $(top_builddir)/src/lib/libsctp.la:
@@ -177,3 +184,6 @@ test_getname_v6_CFLAGS = ${V6FLAGS}
 
 test_tcp_style_v6_SOURCES = test_tcp_style.c
 test_tcp_style_v6_CFLAGS = ${V6FLAGS}
+
+test_interleave_v6_SOURCES = test_interleave.c
+test_interleave_v6_CFLAGS = ${V6FLAGS}
diff --git a/src/func_tests/test_interleave.c b/src/func_tests/test_interleave.c
new file mode 100644
index 0000000..d92e2b0
--- /dev/null
+++ b/src/func_tests/test_interleave.c
@@ -0,0 +1,254 @@
+/* This purpose of this test is to examine the
+ * support of the interleaving
+ * The following tests are done in sequence:
+ * - Verify SCTP_FRAGMENT_INTERLEAVE and SCTP_INTERLEAVING_SUPPORTED
+ *   socket option by doing a setsockopt() followed by a getsockopt()
+ * - Verify the integrity of the data sent by client using a sendmsg()
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/uio.h>
+#include <netinet/in.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <netinet/sctp.h>
+#include <sctputil.h>
+
+#define MSG_SIZE 1000
+
+char *TCID = __FILE__;
+int TST_TOTAL = 2;
+int TST_CNT = 0;
+
+int
+main(int argc, char *argv[])
+{
+	int sk1, sk2;
+	int pf_class;
+	int error;
+	int fd;
+	int msg_len, bytes_sent;
+	int frag_interleave, get_result;
+	sockaddr_storage_t loop1;
+	sockaddr_storage_t loop2;
+	struct iovec iov;
+	struct iovec out_iov;
+	struct msghdr inmessage;
+	struct msghdr outmessage;
+	struct cmsghdr *cmsg;
+	struct sctp_sndrcvinfo *sinfo;
+	struct sctp_assoc_value assoc, get_assoc;
+	uint32_t ppid;
+	uint32_t stream;
+	char *buffer;
+	char setting[4];
+	char incmsg[CMSG_SPACE(sizeof(sctp_cmsg_data_t))];
+	char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
+	void *msg_buffer;
+	socklen_t optlen;
+
+	/* Rather than fflush() throughout the code, set stdout to
+	 * be unbuffered.
+	 */
+	setvbuf(stdout, NULL, _IONBF, 0);
+
+	/* Set some basic values which depend on the address family. */
+#if TEST_V6
+	pf_class = PF_INET6;
+
+	loop1.v6.sin6_family = AF_INET6;
+	loop1.v6.sin6_addr = in6addr_loopback;
+	loop1.v6.sin6_port = htons(SCTP_TESTPORT_1);
+
+	loop2.v6.sin6_family = AF_INET6;
+	loop2.v6.sin6_addr = in6addr_loopback;
+	loop2.v6.sin6_port = htons(SCTP_TESTPORT_2);
+#else
+	pf_class = PF_INET;
+
+	loop1.v4.sin_family = AF_INET;
+	loop1.v4.sin_addr.s_addr = SCTP_IP_LOOPBACK;
+	loop1.v4.sin_port = htons(SCTP_TESTPORT_1);
+
+	loop2.v4.sin_family = AF_INET;
+	loop2.v4.sin_addr.s_addr = SCTP_IP_LOOPBACK;
+	loop2.v4.sin_port = htons(SCTP_TESTPORT_2);
+#endif /* TEST_V6 */
+
+	/* Create the two endpoints which will talk to each other */
+	sk1 = test_socket(pf_class, SOCK_SEQPACKET, IPPROTO_SCTP);
+	sk2 = test_socket(pf_class, SOCK_SEQPACKET, IPPROTO_SCTP);
+
+	/* Enable ASSOC_CHANGE and SNDRCVINFO notifications */
+	test_enable_assoc_change(sk1);
+	test_enable_assoc_change(sk2);
+
+	/* Bind these sockets to the test ports */
+	test_bind(sk1, &loop1.sa, sizeof(loop1));
+	test_bind(sk2, &loop2.sa, sizeof(loop2));
+
+	/* Let sk2 listen to new associations */
+	test_listen(sk2, 1);
+
+	/* TEST #1: verify SCTP_FRAGMENT_INTERLEAVE option
+	 *          followed by a getsockopt()
+	 */
+	frag_interleave = 1;
+	test_setsockopt(sk1, SCTP_FRAGMENT_INTERLEAVE,
+			&frag_interleave, sizeof(frag_interleave));
+	test_setsockopt(sk2, SCTP_FRAGMENT_INTERLEAVE,
+			&frag_interleave, sizeof(frag_interleave));
+
+	tst_resm(TPASS, "setsockopt(SCTP_FRAGMENT_INTERLEAVE)");
+
+	get_result = 0;
+	optlen = sizeof(get_result);
+	error = test_getsockopt(sk1, SCTP_FRAGMENT_INTERLEAVE,
+				&get_result, &optlen);
+	if (get_result != frag_interleave)
+		tst_brkm(TBROK, tst_exit, "getsockopt(SCTP_FRAGMENT_INTERLEAVE) "
+			 "error: %d errno: %d get_result: %d",
+			 error, errno, get_result);
+	get_result = 0;
+	error = test_getsockopt(sk2, SCTP_FRAGMENT_INTERLEAVE,
+				&get_result, &optlen);
+	if (get_result != frag_interleave)
+		tst_brkm(TBROK, tst_exit, "getsockopt(SCTP_FRAGMENT_INTERLEAVE) "
+			 "error: %d errno: %d get_result: %d",
+			 error, errno, get_result);
+
+	tst_resm(TPASS, "getsockopt(SCTP_FRAGMENT_INTERLEAVE)");
+
+	/* Check if net.sctp.intl_enable=1, exit if not */
+	fd = open("/proc/sys/net/sctp/intl_enable", O_RDONLY);
+	if (fd < 0 ||
+	    read(fd, &setting, 4) < 0 ||
+	    strncmp("1", setting, 1) != 0) {
+		tst_resm(TINFO, "intl_enable is not set to 1, skip test\n");
+		return 0;
+	}
+	close(fd);
+
+	assoc.assoc_id = 0;
+	assoc.assoc_value = 1;
+	test_setsockopt(sk1, SCTP_INTERLEAVING_SUPPORTED,
+			&assoc, sizeof(assoc));
+	test_setsockopt(sk2, SCTP_INTERLEAVING_SUPPORTED,
+			&assoc, sizeof(assoc));
+
+	tst_resm(TPASS, "setsockopt(SCTP_INTERLEAVING_SUPPORTED)");
+
+
+	memset(&get_assoc, 0x00, sizeof(struct sctp_assoc_value));
+	optlen = sizeof(get_assoc);
+	error = test_getsockopt(sk1, SCTP_INTERLEAVING_SUPPORTED,
+				&get_assoc, &optlen);
+	if (get_assoc.assoc_value != 1)
+		tst_brkm(TBROK, tst_exit,
+			 "getsockopt(SCTP_INTERLEAVING_SUPPORTED) "
+			 "error: %d errno: %d get_result: %d",
+			 error, errno, get_assoc.assoc_value);
+	error = test_getsockopt(sk2, SCTP_INTERLEAVING_SUPPORTED,
+				&get_assoc, &optlen);
+	if (get_assoc.assoc_value != 1)
+		tst_brkm(TBROK, tst_exit,
+			 "getsockopt(SCTP_INTERLEAVING_SUPPORTED) "
+			 "error: %d errno: %d get_result: %d",
+			 error, errno, get_assoc.assoc_value);
+
+	tst_resm(TPASS, "getsockopt(SCTP_INTERLEAVING_SUPPORTED)");
+	/* End of TEST #1 */
+
+	/* Send the first message to create an association */
+	outmessage.msg_name = &loop2;
+	outmessage.msg_namelen = sizeof(loop2);
+	outmessage.msg_iov = &out_iov;
+	outmessage.msg_iovlen = 1;
+	outmessage.msg_control = outcmsg;
+	outmessage.msg_controllen = sizeof(outcmsg);
+	outmessage.msg_flags = 0;
+	cmsg = CMSG_FIRSTHDR(&outmessage);
+	cmsg->cmsg_level = IPPROTO_SCTP;
+	cmsg->cmsg_type = SCTP_SNDRCV;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
+	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
+	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
+	ppid = rand(); /* Choose an arbitrary value */
+	stream = 1;
+	sinfo->sinfo_ppid = ppid;
+	sinfo->sinfo_stream = stream;
+	msg_len = 10;
+	msg_buffer = test_build_msg(10);
+	outmessage.msg_iov->iov_base = msg_buffer;
+	outmessage.msg_iov->iov_len = msg_len;
+	test_sendmsg(sk1, &outmessage, 0, msg_len);
+
+	/* Initialize inmessage for all receives */
+	buffer = test_malloc(REALLY_BIG);
+	memset(&inmessage, 0x00, sizeof(inmessage));
+	iov.iov_base = buffer;
+	iov.iov_len = REALLY_BIG;
+	inmessage.msg_iov = &iov;
+	inmessage.msg_iovlen = 1;
+	inmessage.msg_control = incmsg;
+
+	/* Get the communication up message on sk2 */
+	inmessage.msg_controllen = sizeof(incmsg);
+	error = test_recvmsg(sk2, &inmessage, MSG_WAITALL);
+	test_check_msg_notification(&inmessage, error,
+				    sizeof(struct sctp_assoc_change),
+				    SCTP_ASSOC_CHANGE, SCTP_COMM_UP);
+
+	/* Get the communication up message on sk1 */
+	inmessage.msg_controllen = sizeof(incmsg);
+	error = test_recvmsg(sk1, &inmessage, MSG_WAITALL);
+	test_check_msg_notification(&inmessage, error,
+				    sizeof(struct sctp_assoc_change),
+				    SCTP_ASSOC_CHANGE, SCTP_COMM_UP);
+
+	/* Get the first message which was sent.  */
+	inmessage.msg_controllen = sizeof(incmsg);
+	error = test_recvmsg(sk2, &inmessage, MSG_WAITALL);
+	test_check_msg_data(&inmessage, error, msg_len, MSG_EOR, stream, ppid);
+
+	/* TEST #2: Verify data integrity */
+	msg_len = MSG_SIZE;
+	msg_buffer = test_build_msg(msg_len);
+	outmessage.msg_iov->iov_base = msg_buffer;
+	outmessage.msg_iov->iov_len = msg_len;
+	bytes_sent = test_sendmsg(sk1, &outmessage, 0, msg_len);
+
+	tst_resm(TINFO, "Sent %d byte message", bytes_sent);
+
+	inmessage.msg_controllen = sizeof(incmsg);
+	error = test_recvmsg(sk2, &inmessage, MSG_WAITALL);
+
+	tst_resm(TINFO, "Received %d byte message", error);
+
+	test_check_msg_data(&inmessage, error, bytes_sent,
+			    MSG_EOR, stream, ppid);
+
+	tst_resm(TPASS, "Received same byte of message");
+	/* End of TEST #2 */
+
+	/* Shut down the link */
+	close(sk1);
+
+	/* Get the shutdown complete notification */
+	inmessage.msg_controllen = sizeof(incmsg);
+	error = test_recvmsg(sk2, &inmessage, MSG_WAITALL);
+	test_check_msg_notification(&inmessage, error,
+				    sizeof(struct sctp_assoc_change),
+				    SCTP_ASSOC_CHANGE, SCTP_SHUTDOWN_COMP);
+	close(sk2);
+
+	free(buffer);
+
+	/* Indicate successful completion */
+	return 0;
+}
-- 
2.37.1

