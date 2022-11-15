Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36569629D9D
	for <lists+linux-sctp@lfdr.de>; Tue, 15 Nov 2022 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiKOPdr (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 15 Nov 2022 10:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiKOPdq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 15 Nov 2022 10:33:46 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A780FB95;
        Tue, 15 Nov 2022 07:33:44 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id e205so10735967oif.11;
        Tue, 15 Nov 2022 07:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T0L71De4RLotJ6mv5c+XOuqMzQ4fPdUKpE+7z6LDOCo=;
        b=WSYxPoJXIId7XtNRlGTmNbzI00ix/m8vkELC0RJn9QyEoj3WdJS0fruQ7jF3iW9evq
         7MTHFOhPK3BYWJEO0q+vrysYz/tS1AfNkN0IJjOCAVwaGerFqSBmFLmtAmQM78cNB6yZ
         tv2DrCk64fd7uH+aGex+rT6onxGYIMPWfDJHhmpBjUR77abWXd7ZCb3pw+uvrR9r4r7z
         Jvqy0kS32l4g32MUW/UR9CDIixHGtFVgyTkiW9aUw5nS5s9A6WubqXpTXZRxZN9ZzJov
         tF2eX8CfCbMns+61bMwHC4yWBHbik43zB+S4kzWpwIKW1li3M+g6Mpy4taeESZqceHa9
         ByCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0L71De4RLotJ6mv5c+XOuqMzQ4fPdUKpE+7z6LDOCo=;
        b=iR05nAps5iaBg5b7oRlXmpyw3Ar0tX5lplKQaR2aES8Hh7kvJKJZWtrWIwIhBESl0T
         NdD1pk45Go6DFntUlDyvkS5Y6gmJtI2QdbzyBkCe0WAExZj7ell/M8qdvUyBe58xfc56
         KZYQ52luwaYxWIdvJsWpybVb8qdKG6sRyyuCYwRrNXC6diXxCLWX/ylEZxy0bH4UoLmU
         M6wKIdRhwgM6H1KcDfHcE+PTS4YST+wfUA6y7INhxJRenulbbNdgSur041ULePKuQb6W
         mBopQXVU5+NUUOa+iAKrZWCqXiJzdCD8el8EZQq2EYYmIL5uqD6A7uxDxKjmHG1Vx+1f
         lUgA==
X-Gm-Message-State: ANoB5pngZ/6HLrYqDYCrEd677NVeDq1LE2W/gXh4aTKqz7MnxZz1dZam
        zQ5OXJvM+J2dmVn6OLHkg8m9Y6hPiz+x/bXn/SOtp7W7j5w=
X-Google-Smtp-Source: AA0mqf48pBxS+YtuKX97X2EPiboVcC9F07dPPAk2VF4sMa+TwFbHmQlUeAyt1bi1LfOB37G7h157ZhFY5glS4WGmaRc=
X-Received: by 2002:a05:6808:f92:b0:35a:13f4:d875 with SMTP id
 o18-20020a0568080f9200b0035a13f4d875mr588738oiw.190.1668526423665; Tue, 15
 Nov 2022 07:33:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668357542.git.lucien.xin@gmail.com> <39a981bc89921aedbff46f9d1e42369e93416d1d.1668357542.git.lucien.xin@gmail.com>
 <49285c832b6ea6fc36eea946206c53cb3c0aea87.camel@redhat.com>
In-Reply-To: <49285c832b6ea6fc36eea946206c53cb3c0aea87.camel@redhat.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 15 Nov 2022 10:33:10 -0500
Message-ID: <CADvbK_eEkE04vC1v-zuD2x6CMtvBmV2HZxPKfAwsF4N0eUi4=g@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] selftests: add a selftest for sctp vrf
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Ahern <dsahern@gmail.com>,
        Carlo Carraro <colrack@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Nov 15, 2022 at 5:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hello,
>
> On Sun, 2022-11-13 at 11:44 -0500, Xin Long wrote:
> > This patch adds 12 small test cases: 01-04 test for the sysctl
> > net.sctp.l3mdev_accept. 05-10 test for only binding to a right
> > l3mdev device, the connection can be created. 11-12 test for
> > two socks binding to different l3mdev devices at the same time,
> > each of them can process the packets from the corresponding
> > peer. The tests run for both IPv4 and IPv6 SCTP.
> >
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  tools/testing/selftests/net/Makefile     |   2 +
> >  tools/testing/selftests/net/sctp_hello.c | 139 ++++++++++++++++++++
> >  tools/testing/selftests/net/sctp_vrf.sh  | 160 +++++++++++++++++++++++
> >  3 files changed, 301 insertions(+)
> >  create mode 100644 tools/testing/selftests/net/sctp_hello.c
> >  create mode 100755 tools/testing/selftests/net/sctp_vrf.sh
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > index cec4800cb017..880e6ded6ed5 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -72,6 +72,8 @@ TEST_GEN_PROGS += sk_bind_sendto_listen
> >  TEST_GEN_PROGS += sk_connect_zero_addr
> >  TEST_PROGS += test_ingress_egress_chaining.sh
> >  TEST_GEN_PROGS += so_incoming_cpu
> > +TEST_PROGS += sctp_vrf.sh
> > +TEST_GEN_FILES += sctp_hello
> >
> >  TEST_FILES := settings
> >
> > diff --git a/tools/testing/selftests/net/sctp_hello.c b/tools/testing/selftests/net/sctp_hello.c
> > new file mode 100644
> > index 000000000000..58f763ca8b47
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/sctp_hello.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/types.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +
> > +static void set_addr(struct sockaddr_storage *ss, char *ip, char *port, int *len)
> > +{
> > +     if (ss->ss_family == AF_INET) {
> > +             struct sockaddr_in *a = (struct sockaddr_in *)ss;
> > +
> > +             a->sin_addr.s_addr = inet_addr(ip);
> > +             a->sin_port = htons(atoi(port));
> > +             *len = sizeof(*a);
> > +     } else {
> > +             struct sockaddr_in6 *a = (struct sockaddr_in6 *)ss;
> > +
> > +             a->sin6_family = AF_INET6;
> > +             inet_pton(AF_INET6, ip, &a->sin6_addr);
> > +             a->sin6_port = htons(atoi(port));
> > +             *len = sizeof(*a);
> > +     }
> > +}
> > +
> > +static int do_client(int argc, char *argv[])
> > +{
> > +     struct sockaddr_storage ss;
> > +     char buf[] = "hello";
> > +     int csk, ret, len;
> > +
> > +     if (argc < 5) {
> > +             printf("%s client -4|6 IP PORT [IP PORT]\n", argv[0]);
> > +             return -1;
> > +     }
> > +
> > +     bzero((void *)&ss, sizeof(ss));
> > +     ss.ss_family = !strcmp(argv[2], "-4") ? AF_INET : AF_INET6;
> > +     csk = socket(ss.ss_family, SOCK_STREAM, IPPROTO_SCTP);
> > +     if (csk < 0) {
> > +             printf("failed to create socket\n");
> > +             return -1;
> > +     }
> > +
> > +     if (argc >= 7) {
> > +             set_addr(&ss, argv[5], argv[6], &len);
> > +             ret = bind(csk, (struct sockaddr *)&ss, len);
> > +             if (ret < 0) {
> > +                     printf("failed to bind to address\n");
> > +                     return -1;
> > +             }
> > +     }
> > +
> > +     set_addr(&ss, argv[3], argv[4], &len);
> > +     ret = connect(csk, (struct sockaddr *)&ss, len);
> > +     if (ret < 0) {
> > +             printf("failed to connect to peer\n");
> > +             return -1;
> > +     }
> > +
> > +     ret = send(csk, buf, strlen(buf) + 1, 0);
> > +     if (ret < 0) {
> > +             printf("failed to send msg %d\n", ret);
> > +             return -1;
> > +     }
> > +     sleep(1);
> > +     close(csk);
> > +
> > +     return 0;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     struct sockaddr_storage ss;
> > +     int lsk, csk, ret, len;
> > +     char buf[20];
> > +
> > +     if (argc < 2 || (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
> > +             printf("%s server|client ...\n", argv[0]);
> > +             return -1;
> > +     }
> > +
> > +     if (!strcmp(argv[1], "client"))
> > +             return do_client(argc, argv);
> > +
> > +     if (argc < 5) {
> > +             printf("%s server -4|6 IP PORT [IFACE]\n", argv[0]);
> > +             return -1;
> > +     }
> > +
> > +     ss.ss_family = !strcmp(argv[2], "-4") ? AF_INET : AF_INET6;
> > +     lsk = socket(ss.ss_family, SOCK_STREAM, IPPROTO_SCTP);
> > +     if (lsk < 0) {
> > +             printf("failed to create lsk\n");
> > +             return -1;
> > +     }
> > +
> > +     if (argc >= 6) {
> > +             ret = setsockopt(lsk, SOL_SOCKET, SO_BINDTODEVICE,
> > +                              argv[5], strlen(argv[5]) + 1);
> > +             if (ret < 0) {
> > +                     printf("failed to bind to device\n");
> > +                     return -1;
> > +             }
> > +     }
> > +
> > +     set_addr(&ss, argv[3], argv[4], &len);
> > +     ret = bind(lsk, (struct sockaddr *)&ss, len);
> > +     if (ret < 0) {
> > +             printf("failed to bind to address\n");
> > +             return -1;
> > +     }
> > +
> > +     ret = listen(lsk, 5);
> > +     if (ret < 0) {
> > +             printf("failed to listen on port\n");
> > +             return -1;
> > +     }
> > +
> > +     csk = accept(lsk, (struct sockaddr *)NULL, (socklen_t *)NULL);
> > +     if (csk < 0) {
> > +             printf("failed to accept new client\n");
> > +             return -1;
> > +     }
> > +
> > +     ret = recv(csk, buf, sizeof(buf), 0);
> > +     if (ret <= 0) {
> > +             printf("failed to recv msg %d\n", ret);
> > +             return -1;
> > +     }
> > +     sleep(2);
>
> Why do you need such sleep here? aren't blocking operations on socket
> enough?
>
> > +     close(csk);
> > +     close(lsk);
> > +
> > +     return 0;
> > +}
> > diff --git a/tools/testing/selftests/net/sctp_vrf.sh b/tools/testing/selftests/net/sctp_vrf.sh
> > new file mode 100755
> > index 000000000000..310749f58386
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/sctp_vrf.sh
> > @@ -0,0 +1,160 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Testing For SCTP VRF.
> > +# TOPO: CLIENT_NS1 (veth1) <---> (veth1) -> vrf_s1
> > +#                                                  SERVER_NS
> > +#       CLIENT_NS2 (veth1) <---> (veth2) -> vrf_s2
> > +
> > +CLIENT_NS1="client-ns1"
> > +CLIENT_NS2="client-ns2"
> > +CLIENT_IP4="10.0.0.1"
> > +CLIENT_IP6="2000::1"
> > +CLIENT_PORT=1234
> > +
> > +SERVER_NS="server-ns"
> > +SERVER_IP4="10.0.0.2"
> > +SERVER_IP6="2000::2"
> > +SERVER_PORT=1234
> > +
> > +setup() {
> > +     modprobe sctp
> > +     ip netns add $CLIENT_NS1
> > +     ip netns add $CLIENT_NS2
> > +     ip netns add $SERVER_NS
> > +     ip -n $SERVER_NS link add veth1 type veth peer name veth1 netns $CLIENT_NS1
> > +     ip -n $SERVER_NS link add veth2 type veth peer name veth1 netns $CLIENT_NS2
> > +
> > +     ip -n $CLIENT_NS1 link set veth1 up
> > +     ip -n $CLIENT_NS1 addr add $CLIENT_IP4/24 dev veth1
> > +     ip -n $CLIENT_NS1 addr add $CLIENT_IP6/24 dev veth1
> > +
> > +     ip -n $CLIENT_NS2 link set veth1 up
> > +     ip -n $CLIENT_NS2 addr add $CLIENT_IP4/24 dev veth1
> > +     ip -n $CLIENT_NS2 addr add $CLIENT_IP6/24 dev veth1
> > +
> > +     ip -n $SERVER_NS link add dummy1 type dummy
> > +     ip -n $SERVER_NS link set dummy1 up
> > +     ip -n $SERVER_NS link add vrf-1 type vrf table 10
> > +     ip -n $SERVER_NS link add vrf-2 type vrf table 20
> > +     ip -n $SERVER_NS link set vrf-1 up
> > +     ip -n $SERVER_NS link set vrf-2 up
> > +     ip -n $SERVER_NS link set veth1 master vrf-1
> > +     ip -n $SERVER_NS link set veth2 master vrf-2
> > +
> > +     ip -n $SERVER_NS addr add $SERVER_IP4/24 dev dummy1
> > +     ip -n $SERVER_NS addr add $SERVER_IP4/24 dev veth1
> > +     ip -n $SERVER_NS addr add $SERVER_IP4/24 dev veth2
> > +     ip -n $SERVER_NS addr add $SERVER_IP6/24 dev dummy1
> > +     ip -n $SERVER_NS addr add $SERVER_IP6/24 dev veth1
> > +     ip -n $SERVER_NS addr add $SERVER_IP6/24 dev veth2
> > +
> > +     ip -n $SERVER_NS link set veth1 up
> > +     ip -n $SERVER_NS link set veth2 up
> > +     sleep 3
>
> I guess you need this 'sleep' to wait for dad completion on the above
> ipv6 addresses. If so, you can avoid the sleep adding 'nodad' to the ip
> route command line.
sounds good, I will give it a try.

>
> > +     ip -n $SERVER_NS route add table 10 $CLIENT_IP4 dev veth1 src $SERVER_IP4
> > +     ip -n $SERVER_NS route add table 20 $CLIENT_IP4 dev veth2 src $SERVER_IP4
> > +     ip -n $SERVER_NS route add $CLIENT_IP4 dev veth1 src $SERVER_IP4
> > +     ip -n $SERVER_NS route add table 10 $CLIENT_IP6 dev veth1 src $SERVER_IP6
> > +     ip -n $SERVER_NS route add table 20 $CLIENT_IP6 dev veth2 src $SERVER_IP6
> > +     ip -n $SERVER_NS route add $CLIENT_IP6 dev veth1 src $SERVER_IP6
> > +
> > +     L3MDEV=`ip netns exec $SERVER_NS cat /proc/sys/net/sctp/l3mdev_accept`
> > +}
> > +
> > +cleanup() {
> > +     ip netns exec $SERVER_NS echo $L3MDEV > /proc/sys/net/sctp/l3mdev_accept
> > +     ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
> > +     ip netns del "$CLIENT_NS1"
> > +     ip netns del "$CLIENT_NS2"
> > +     ip netns del "$SERVER_NS"
> > +}
> > +
> > +do_testx() {
> > +     IFACE1=$1
> > +     IFACE2=$2
> > +
> > +     ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
> > +     ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
> > +             $SERVER_PORT $IFACE1 2>&1 >/dev/null &
> > +     disown
> > +     ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
> > +             $SERVER_PORT $IFACE2 2>&1 >/dev/null &
> > +     disown
> > +     sleep 1
>
> Altertantivelly you can wait untill the relevant sctp socket is liste
> by 'ss' output, it would be more roboust.
right, this one looks better :-).
>
> > +     timeout 3 ip netns exec $CLIENT_NS1 ./sctp_hello client $AF \
> > +             $SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null && \
> > +     timeout 3 ip netns exec $CLIENT_NS2 ./sctp_hello client $AF \
> > +             $SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
> > +}
> > +
> > +do_test() {
> > +     CLIENT_NS=$1
> > +     IFACE=$2
> > +
> > +     ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
> > +     ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
> > +             $SERVER_PORT $IFACE 2>&1 >/dev/null &
> > +     disown
> > +     sleep 1
> > +     timeout 3 ip netns exec $CLIENT_NS ./sctp_hello client $AF \
> > +             $SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
> > +}
> > +
> > +testup() {
> > +     ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=1 2>&1 >/dev/null
> > +     echo -n "TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y "
> > +     do_test $CLIENT_NS1 || { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 02: nobind, connect from client 2, l3mdev_accept=1, N "
> > +     do_test $CLIENT_NS2 && { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=0 2>&1 >/dev/null
> > +     echo -n "TEST 03: nobind, connect from client 1, l3mdev_accept=0, N "
> > +     do_test $CLIENT_NS1 && { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 04: nobind, connect from client 2, l3mdev_accept=0, N "
> > +     do_test $CLIENT_NS2 && { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 05: bind veth2 in server, connect from client 1, N "
> > +     do_test $CLIENT_NS1 veth2 && { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 06: bind veth1 in server, connect from client 1, Y "
> > +     do_test $CLIENT_NS1 veth1 || { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 07: bind vrf-1 in server, connect from client 1, Y "
> > +     do_test $CLIENT_NS1 vrf-1 || { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 08: bind vrf-2 in server, connect from client 1, N "
> > +     do_test $CLIENT_NS1 vrf-2 && { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 09: bind vrf-2 in server, connect from client 2, Y "
> > +     do_test $CLIENT_NS2 vrf-2 || { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 10: bind vrf-1 in server, connect from client 2, N "
> > +     do_test $CLIENT_NS2 vrf-1 && { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 11: bind vrf-1 & 2 in server, connect from client 1 & 2, Y "
> > +     do_testx vrf-1 vrf-2 || { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +
> > +     echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N "
> > +     do_testx vrf-2 vrf-1 || { echo "[FAIL]"; return 1; }
> > +     echo "[PASS]"
> > +}
> > +
> > +trap cleanup EXIT
> > +setup || exit $?
> > +echo "Testing For SCTP VRF:"
> > +CLIENT_IP=$CLIENT_IP4 SERVER_IP=$SERVER_IP4 AF="-4" testup && echo "***v4 Tests Done***" &&
> > +CLIENT_IP=$CLIENT_IP6 SERVER_IP=$SERVER_IP6 AF="-6" testup && echo "***v6 Tests Done***"
>
> To properly integrate with the self-test suite, you need to ensure that
> the script exits with an error code in case of failure, e.g. storing
> the error in a global variable 'ret' and adding a final:
>
> exit $ret
the above lines are equal to "exit $ret".
the exit code in testup() will return if it's not 0.
Do you mean I should make it more clear?

Thanks for the review.
>
> Cheers,
>
> Paolo
>
