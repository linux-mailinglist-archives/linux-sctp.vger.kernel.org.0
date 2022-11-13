Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A56B6270F3
	for <lists+linux-sctp@lfdr.de>; Sun, 13 Nov 2022 17:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiKMQpG (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 13 Nov 2022 11:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiKMQo4 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 13 Nov 2022 11:44:56 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80411814;
        Sun, 13 Nov 2022 08:44:55 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 8so6147879qka.1;
        Sun, 13 Nov 2022 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZackvea4312ND5c6kAVcjHrGHQTaIiyNnwXHK+IysM=;
        b=cfLsQ0cB/LVnz7B2gq1xfktZoc6JvvhWbntcpjJitgjIafAv4H5RLNBH3E6yERhQnH
         fTWpr7FRqObTT+wEQwCx04Ay5KXXSg4liuwtThsdPHAu7QV9zPRQhuIL6XtFZibdc5JY
         IQAhTgP0s74cc161qvdTCl9YOeeKLVdhRK6hY+lcr5WVSfjEhnWUkGAmdKUPdm4rG1+L
         KB/uiHAhCec0a+k90+ruCBcNmO8R8ptU2TVwPvd0UoThoXcAMtyMlsmp/edvf0+1VQSb
         0hnnfEB1ryqgjJrCCuAlMBoOCU5R9D/mGiAG6h0V3PsLHJgTgEin1S7QB3701ZGM9DOg
         cs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZackvea4312ND5c6kAVcjHrGHQTaIiyNnwXHK+IysM=;
        b=NeSopSFz2aaLrt1/nBUz2QkpVyfk5xrVjCoIlm9uffk7vhVXDX6Kb9DS0ozvF+Vux+
         PsCrgSMbmR9BZmYMqCt2X4cYjEsdisk87ojr4XoDj6mYxfY9GUARwYoQsK2BLr2V3jTu
         EEQtSyZ6OQkdZ1/K2+n3lYigkVjeZZcyjz4fKXK5a54zn4moUwcIKsUWMQnuY7RpZoRI
         49IhP1cKJBQz4Rd5484JbyzcYpmqsBU/OEPjOSYqSoMi1KQ21XveKdFkLDpmJQSLnqx0
         rrQ5jFwYBvjmZnF/RlwSgumiT5L2B7C6mf3g73iJypSlwVoeW5h/4ldreCyd0qE8KPfX
         v/Qg==
X-Gm-Message-State: ANoB5pmI8E4EsVhFPye4J3Txvi7a6gSXocc12C0+W+L63D3TZvil/rpF
        UxXvGOLWmBtCeqnL295jtTCZF75q8bulQQ==
X-Google-Smtp-Source: AA0mqf5i//0NfkPMTiOOXOIItvQemrMSz5ZNigp+JahPg0rQJ56lsnN2hm5KuC6bQg9rsjueYeOBEg==
X-Received: by 2002:a37:e210:0:b0:6f7:65f6:a857 with SMTP id g16-20020a37e210000000b006f765f6a857mr8188938qki.598.1668357894035;
        Sun, 13 Nov 2022 08:44:54 -0800 (PST)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id cf8-20020a05622a400800b0035d08c1da35sm4429191qtb.45.2022.11.13.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 08:44:53 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Ahern <dsahern@gmail.com>,
        Carlo Carraro <colrack@gmail.com>
Subject: [PATCH net-next 7/7] selftests: add a selftest for sctp vrf
Date:   Sun, 13 Nov 2022 11:44:43 -0500
Message-Id: <39a981bc89921aedbff46f9d1e42369e93416d1d.1668357542.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1668357542.git.lucien.xin@gmail.com>
References: <cover.1668357542.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This patch adds 12 small test cases: 01-04 test for the sysctl
net.sctp.l3mdev_accept. 05-10 test for only binding to a right
l3mdev device, the connection can be created. 11-12 test for
two socks binding to different l3mdev devices at the same time,
each of them can process the packets from the corresponding
peer. The tests run for both IPv4 and IPv6 SCTP.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 tools/testing/selftests/net/Makefile     |   2 +
 tools/testing/selftests/net/sctp_hello.c | 139 ++++++++++++++++++++
 tools/testing/selftests/net/sctp_vrf.sh  | 160 +++++++++++++++++++++++
 3 files changed, 301 insertions(+)
 create mode 100644 tools/testing/selftests/net/sctp_hello.c
 create mode 100755 tools/testing/selftests/net/sctp_vrf.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index cec4800cb017..880e6ded6ed5 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -72,6 +72,8 @@ TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
 TEST_PROGS += test_ingress_egress_chaining.sh
 TEST_GEN_PROGS += so_incoming_cpu
+TEST_PROGS += sctp_vrf.sh
+TEST_GEN_FILES += sctp_hello
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/net/sctp_hello.c b/tools/testing/selftests/net/sctp_hello.c
new file mode 100644
index 000000000000..58f763ca8b47
--- /dev/null
+++ b/tools/testing/selftests/net/sctp_hello.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+static void set_addr(struct sockaddr_storage *ss, char *ip, char *port, int *len)
+{
+	if (ss->ss_family == AF_INET) {
+		struct sockaddr_in *a = (struct sockaddr_in *)ss;
+
+		a->sin_addr.s_addr = inet_addr(ip);
+		a->sin_port = htons(atoi(port));
+		*len = sizeof(*a);
+	} else {
+		struct sockaddr_in6 *a = (struct sockaddr_in6 *)ss;
+
+		a->sin6_family = AF_INET6;
+		inet_pton(AF_INET6, ip, &a->sin6_addr);
+		a->sin6_port = htons(atoi(port));
+		*len = sizeof(*a);
+	}
+}
+
+static int do_client(int argc, char *argv[])
+{
+	struct sockaddr_storage ss;
+	char buf[] = "hello";
+	int csk, ret, len;
+
+	if (argc < 5) {
+		printf("%s client -4|6 IP PORT [IP PORT]\n", argv[0]);
+		return -1;
+	}
+
+	bzero((void *)&ss, sizeof(ss));
+	ss.ss_family = !strcmp(argv[2], "-4") ? AF_INET : AF_INET6;
+	csk = socket(ss.ss_family, SOCK_STREAM, IPPROTO_SCTP);
+	if (csk < 0) {
+		printf("failed to create socket\n");
+		return -1;
+	}
+
+	if (argc >= 7) {
+		set_addr(&ss, argv[5], argv[6], &len);
+		ret = bind(csk, (struct sockaddr *)&ss, len);
+		if (ret < 0) {
+			printf("failed to bind to address\n");
+			return -1;
+		}
+	}
+
+	set_addr(&ss, argv[3], argv[4], &len);
+	ret = connect(csk, (struct sockaddr *)&ss, len);
+	if (ret < 0) {
+		printf("failed to connect to peer\n");
+		return -1;
+	}
+
+	ret = send(csk, buf, strlen(buf) + 1, 0);
+	if (ret < 0) {
+		printf("failed to send msg %d\n", ret);
+		return -1;
+	}
+	sleep(1);
+	close(csk);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_storage ss;
+	int lsk, csk, ret, len;
+	char buf[20];
+
+	if (argc < 2 || (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
+		printf("%s server|client ...\n", argv[0]);
+		return -1;
+	}
+
+	if (!strcmp(argv[1], "client"))
+		return do_client(argc, argv);
+
+	if (argc < 5) {
+		printf("%s server -4|6 IP PORT [IFACE]\n", argv[0]);
+		return -1;
+	}
+
+	ss.ss_family = !strcmp(argv[2], "-4") ? AF_INET : AF_INET6;
+	lsk = socket(ss.ss_family, SOCK_STREAM, IPPROTO_SCTP);
+	if (lsk < 0) {
+		printf("failed to create lsk\n");
+		return -1;
+	}
+
+	if (argc >= 6) {
+		ret = setsockopt(lsk, SOL_SOCKET, SO_BINDTODEVICE,
+				 argv[5], strlen(argv[5]) + 1);
+		if (ret < 0) {
+			printf("failed to bind to device\n");
+			return -1;
+		}
+	}
+
+	set_addr(&ss, argv[3], argv[4], &len);
+	ret = bind(lsk, (struct sockaddr *)&ss, len);
+	if (ret < 0) {
+		printf("failed to bind to address\n");
+		return -1;
+	}
+
+	ret = listen(lsk, 5);
+	if (ret < 0) {
+		printf("failed to listen on port\n");
+		return -1;
+	}
+
+	csk = accept(lsk, (struct sockaddr *)NULL, (socklen_t *)NULL);
+	if (csk < 0) {
+		printf("failed to accept new client\n");
+		return -1;
+	}
+
+	ret = recv(csk, buf, sizeof(buf), 0);
+	if (ret <= 0) {
+		printf("failed to recv msg %d\n", ret);
+		return -1;
+	}
+	sleep(2);
+	close(csk);
+	close(lsk);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/net/sctp_vrf.sh b/tools/testing/selftests/net/sctp_vrf.sh
new file mode 100755
index 000000000000..310749f58386
--- /dev/null
+++ b/tools/testing/selftests/net/sctp_vrf.sh
@@ -0,0 +1,160 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing For SCTP VRF.
+# TOPO: CLIENT_NS1 (veth1) <---> (veth1) -> vrf_s1
+#                                                  SERVER_NS
+#       CLIENT_NS2 (veth1) <---> (veth2) -> vrf_s2
+
+CLIENT_NS1="client-ns1"
+CLIENT_NS2="client-ns2"
+CLIENT_IP4="10.0.0.1"
+CLIENT_IP6="2000::1"
+CLIENT_PORT=1234
+
+SERVER_NS="server-ns"
+SERVER_IP4="10.0.0.2"
+SERVER_IP6="2000::2"
+SERVER_PORT=1234
+
+setup() {
+	modprobe sctp
+	ip netns add $CLIENT_NS1
+	ip netns add $CLIENT_NS2
+	ip netns add $SERVER_NS
+	ip -n $SERVER_NS link add veth1 type veth peer name veth1 netns $CLIENT_NS1
+	ip -n $SERVER_NS link add veth2 type veth peer name veth1 netns $CLIENT_NS2
+
+	ip -n $CLIENT_NS1 link set veth1 up
+	ip -n $CLIENT_NS1 addr add $CLIENT_IP4/24 dev veth1
+	ip -n $CLIENT_NS1 addr add $CLIENT_IP6/24 dev veth1
+
+	ip -n $CLIENT_NS2 link set veth1 up
+	ip -n $CLIENT_NS2 addr add $CLIENT_IP4/24 dev veth1
+	ip -n $CLIENT_NS2 addr add $CLIENT_IP6/24 dev veth1
+
+	ip -n $SERVER_NS link add dummy1 type dummy
+	ip -n $SERVER_NS link set dummy1 up
+	ip -n $SERVER_NS link add vrf-1 type vrf table 10
+	ip -n $SERVER_NS link add vrf-2 type vrf table 20
+	ip -n $SERVER_NS link set vrf-1 up
+	ip -n $SERVER_NS link set vrf-2 up
+	ip -n $SERVER_NS link set veth1 master vrf-1
+	ip -n $SERVER_NS link set veth2 master vrf-2
+
+	ip -n $SERVER_NS addr add $SERVER_IP4/24 dev dummy1
+	ip -n $SERVER_NS addr add $SERVER_IP4/24 dev veth1
+	ip -n $SERVER_NS addr add $SERVER_IP4/24 dev veth2
+	ip -n $SERVER_NS addr add $SERVER_IP6/24 dev dummy1
+	ip -n $SERVER_NS addr add $SERVER_IP6/24 dev veth1
+	ip -n $SERVER_NS addr add $SERVER_IP6/24 dev veth2
+
+	ip -n $SERVER_NS link set veth1 up
+	ip -n $SERVER_NS link set veth2 up
+	sleep 3
+	ip -n $SERVER_NS route add table 10 $CLIENT_IP4 dev veth1 src $SERVER_IP4
+	ip -n $SERVER_NS route add table 20 $CLIENT_IP4 dev veth2 src $SERVER_IP4
+	ip -n $SERVER_NS route add $CLIENT_IP4 dev veth1 src $SERVER_IP4
+	ip -n $SERVER_NS route add table 10 $CLIENT_IP6 dev veth1 src $SERVER_IP6
+	ip -n $SERVER_NS route add table 20 $CLIENT_IP6 dev veth2 src $SERVER_IP6
+	ip -n $SERVER_NS route add $CLIENT_IP6 dev veth1 src $SERVER_IP6
+
+	L3MDEV=`ip netns exec $SERVER_NS cat /proc/sys/net/sctp/l3mdev_accept`
+}
+
+cleanup() {
+	ip netns exec $SERVER_NS echo $L3MDEV > /proc/sys/net/sctp/l3mdev_accept
+	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
+	ip netns del "$CLIENT_NS1"
+	ip netns del "$CLIENT_NS2"
+	ip netns del "$SERVER_NS"
+}
+
+do_testx() {
+	IFACE1=$1
+	IFACE2=$2
+
+	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
+	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
+		$SERVER_PORT $IFACE1 2>&1 >/dev/null &
+	disown
+	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
+		$SERVER_PORT $IFACE2 2>&1 >/dev/null &
+	disown
+	sleep 1
+	timeout 3 ip netns exec $CLIENT_NS1 ./sctp_hello client $AF \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null && \
+	timeout 3 ip netns exec $CLIENT_NS2 ./sctp_hello client $AF \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+}
+
+do_test() {
+	CLIENT_NS=$1
+	IFACE=$2
+
+	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
+	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
+		$SERVER_PORT $IFACE 2>&1 >/dev/null &
+	disown
+	sleep 1
+	timeout 3 ip netns exec $CLIENT_NS ./sctp_hello client $AF \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+}
+
+testup() {
+	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=1 2>&1 >/dev/null
+	echo -n "TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y "
+	do_test $CLIENT_NS1 || { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 02: nobind, connect from client 2, l3mdev_accept=1, N "
+	do_test $CLIENT_NS2 && { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=0 2>&1 >/dev/null
+	echo -n "TEST 03: nobind, connect from client 1, l3mdev_accept=0, N "
+	do_test $CLIENT_NS1 && { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 04: nobind, connect from client 2, l3mdev_accept=0, N "
+	do_test $CLIENT_NS2 && { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 05: bind veth2 in server, connect from client 1, N "
+	do_test $CLIENT_NS1 veth2 && { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 06: bind veth1 in server, connect from client 1, Y "
+	do_test $CLIENT_NS1 veth1 || { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 07: bind vrf-1 in server, connect from client 1, Y "
+	do_test $CLIENT_NS1 vrf-1 || { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 08: bind vrf-2 in server, connect from client 1, N "
+	do_test $CLIENT_NS1 vrf-2 && { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 09: bind vrf-2 in server, connect from client 2, Y "
+	do_test $CLIENT_NS2 vrf-2 || { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 10: bind vrf-1 in server, connect from client 2, N "
+	do_test $CLIENT_NS2 vrf-1 && { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 11: bind vrf-1 & 2 in server, connect from client 1 & 2, Y "
+	do_testx vrf-1 vrf-2 || { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+
+	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N "
+	do_testx vrf-2 vrf-1 || { echo "[FAIL]"; return 1; }
+	echo "[PASS]"
+}
+
+trap cleanup EXIT
+setup || exit $?
+echo "Testing For SCTP VRF:"
+CLIENT_IP=$CLIENT_IP4 SERVER_IP=$SERVER_IP4 AF="-4" testup && echo "***v4 Tests Done***" &&
+CLIENT_IP=$CLIENT_IP6 SERVER_IP=$SERVER_IP6 AF="-6" testup && echo "***v6 Tests Done***"
-- 
2.31.1

