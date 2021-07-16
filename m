Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5273CB325
	for <lists+linux-sctp@lfdr.de>; Fri, 16 Jul 2021 09:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhGPHTF (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 16 Jul 2021 03:19:05 -0400
Received: from mail-am6eur05on2135.outbound.protection.outlook.com ([40.107.22.135]:53121
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235173AbhGPHTF (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 16 Jul 2021 03:19:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuuMPNeOmnRNSKbAuUhqx/+gI2uLLSNJ7LZuPM1mndd4+jjDUBf9e6fB/7BAFoFmCOhzrWo+mO1dmh9nTissIDrGg5eobkMKG6FalnU6NJy9zFhus7s87iesKTj3kznGgTiOu5eiWXAa9dgp8GNAEC89exusqtDKfmfODADu+0Rvtl65/urwxG/keJTqWlhJKqfYgtO72oxt7fYnyspDRx4xsh2uL27M/SP71DCG6/ll+W6pnXMoLw9DSxAyLjzOGTwiTbFvNobKQbWTPonv/WK6Q976YgimPnh5wC6dekgjOD/tShh6iMyu3Nhql2VbTp6Uh146u82rzHK9hFT0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PrAdiF+eaJaFlGv0DtDLnHGik2jRomHU31/7z2nORk=;
 b=aeMii2nOIybQ0tCXyANS9zKe1MQ4rftz16hFwTll2+UrP4b+IVWd5onze5UEn9FB73+sUdNbMg8zwQP4PExdhe8RdhEWwAyL4NcZQXQ+cKmt63isTkTOuykYoo8S3dBPmeau6c0ge29WQDvJAW6uXtFHT1QVaRc3Wbx1ZFu5+3KFACe9Iuq3OlxsbbIdPpHznPBeVGWyVs9zjBb3kt+tvjCFgn34ApEW36BgP7br/G/BE3l7r/Uox6j7cEz91KJ312QyoVHbePKpwWd7UzIVpVouWU5NksQ4cVV/fXnSwpmSivvr6WOKav41EwZlNinVEyVDza1t+P+nnVEhHE9fFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PrAdiF+eaJaFlGv0DtDLnHGik2jRomHU31/7z2nORk=;
 b=htn+57AcnZuZGfrAZgqpn8bkqblJ/O1mf3YueNm1e487rnohxK7HYoqgvkP+b4nKd2ylJ86TThyPZ3OlXqcOhJcUvGY9203G4utlatiF9N0vf684oKKRth6R/EDbR2OLqOpE9ot6wpDb2EGMPhg1Yr7O8HbhCit5wqmV75gqWZ0=
Received: from DB8PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:10:be::31)
 by HE1PR0701MB2683.eurprd07.prod.outlook.com (2603:10a6:3:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.14; Fri, 16 Jul
 2021 07:16:08 +0000
Received: from DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::dd) by DB8PR03CA0018.outlook.office365.com
 (2603:10a6:10:be::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 07:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 DB5EUR03FT011.mail.protection.outlook.com (10.152.20.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 07:16:07 +0000
Received: from wrlinb133.emea.nsn-net.net (wrlinb133.emea.nsn-net.net [10.159.92.203])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 16G7G4Ve005023;
        Fri, 16 Jul 2021 07:16:04 GMT
From:   Jacek Szafraniec <jacek.szafraniec@nokia.com>
To:     linux-sctp@vger.kernel.org
Cc:     Jacek Szafraniec <jacek.szafraniec@nokia.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Maciej Kwiecien <maciej.kwiecien@nokia.com>
Subject: [PATCH 0/1] sctp: do not update t->pathmtu when PMTUD is disabled
Date:   Fri, 16 Jul 2021 09:15:59 +0200
Message-Id: <20210716071600.53150-1-jacek.szafraniec@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 238a3c18-d6d7-4b67-3a2d-08d9482994ea
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2683:
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2683C98A920BE82A8895414B83119@HE1PR0701MB2683.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2a0I36LBy6h2khlQ0xRO62bLUFEU6+piGrXGKfhIbN/OHfnP9MFASB314Sknh6Ka+0JrRIzHSfXz7oqO1AbruCc1kv9U5aT7Z1jWzV7DvVML3OafiTgYLI0vMuwzZJ0j+AeHiyegx3mg0+C1SJOApGJYHPatdu2n5Xx+mmFCoX2Kb3WV4s6+HmX1pSWrVrPYw3dHSm0+HsMpo5egX+phDtm0IQJ0C8x5sIJRc1D2dlqUyjBpr8UArcK1XOI9d7YWhu4+TstXBmij+KMzTcjf4HTWDzvRFu1eAVwunxl3Tx2RZiMm8e++ZKAIVO09RpsobZfUeFCaJWLAxZrOwYdXTVImZKh6pk05s1IBykFQFJORthOG9wyAf4ew9OrGQCdpY1uLXxQ6rqiVwM3QuYO5zzKxlmnd5WK0mlWbflte/lPmSwaKs9taKXO9j0XyK/K1/KXb0Fu4NJMLTh54EJKrmq/nfa1E4FSTLkzNtnRyNHwI1t5oSnDRncHKH9ZFE8/SX0rDKsHXSXvpcAKiOsTCVLcTwX7icOFawNg5t4w2s4ofE/jthMljfSFjqpkeQFmKgKs4BTPYj8og1m6DmNT1KKzApg1CtBc0mTZcKRLFcYoVwIWlgfBccUJVJ2VBcx7nwctJf5gGh5/hoCIe9K1RfUOxWCRffOBvc1w32iY7qZkaOY3jTm96UhdksO1zOb9PBv6MonttJPkU0qFT9tZUw12OLeR6rnjT+9yMA8F9OHE=
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(8676002)(4326008)(2616005)(15650500001)(82310400003)(107886003)(336012)(356005)(36756003)(86362001)(6666004)(26005)(186003)(8936002)(478600001)(36860700001)(81166007)(2906002)(70206006)(47076005)(70586007)(30864003)(6916009)(44832011)(82740400003)(54906003)(83380400001)(66574015)(316002)(5660300002)(1076003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 07:16:07.7883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 238a3c18-d6d7-4b67-3a2d-08d9482994ea
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2683
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

1. Describe your problem:

Since 69fec325a64383667b8a35df5d48d6ce52fb2782 SCTP changed behavior
for GSO offload.

commit 69fec325a64383667b8a35df5d48d6ce52fb2782
Author: Xin Long <lucien.xin@gmail.com>
Date:   Sun Nov 18 16:14:47 2018 +0800

    Revert "sctp: remove sctp_transport_pmtu_check"

    This reverts commit 22d7be267eaa8114dcc28d66c1c347f667d7878a.

    The dst's mtu in transport can be updated by a non sctp place like
    in xfrm where the MTU information didn't get synced between asoc,
    transport and dst, so it is still needed to do the pmtu check
    in sctp_packet_config.

    Acked-by: Neil Horman <nhorman@tuxdriver.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

SCTP GSO behaviour is different while spp_pathmtu is configured
intentionally below bound interface(and route) MTU and PMTUD is
disabled.

2. Topology:

Sender <- (MTU 4098) -> router <- (MTU 1500) -> Receiver

3. To reproduce the case:
    1. configure spp_flags = !SPP_PMTUD_ENABLE & SPP_PMTUD_DISABLE
    2. configure spp_pathmtu 1392
    3. send 2000 message

4. Snippet of log with behavior compare:

behavior pre 69fec325a64383667b8a35df5d48d6ce52fb2782:

IP packet got 2 chunks bundled to be offloaded by kernel:

2004-01-01T00:06:38.231152+00:00 fct [debug]   kernel: [  420.781878] sctp: ***sctp_transmit_packet***
2004-01-01T00:06:38.231159+00:00 fct [debug]   kernel: [  420.781887] sctp: *** Chunk:80000000842d7100[DATA] TSN 0xf065bb80, length:1360, chunk->skb->len:1360, rtt_in_progress:1
2004-01-01T00:06:38.231166+00:00 fct [debug]   kernel: [  420.781895] sctp: *** Chunk:80000000842d7800[DATA] TSN 0xf065bb81, length:672, chunk->skb->len:672, rtt_in_progress:0
2004-01-01T00:06:38.231174+00:00 fct [debug]   kernel: [  420.781901] sctp: ***sctp_transmit_packet*** (head)skb->len:2044

Frame is offloaded:
root@fct:~ >tcpdump -i rio0m3 sctp -vvNep
tcpdump: listening on rio0m3, link-type EN10MB (Ethernet), capture size 262144 bytes
    fct.35341 > 192.168.253.16.12345: sctp
1) [INIT] [init tag: 2900307017] [rwnd: 1048576] [OS: 10] [MIS: 65535] [init TSN: 4033198976]
00:06:37.693554 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 312: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 292)
    192.168.253.16.12345 > fct.35341: sctp
1) [INIT ACK] [init tag: 2511511675] [rwnd: 1048576] [OS: 10] [MIS: 10] [init TSN: 4053520386]
00:06:37.693709 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 278: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 264)
    fct.35341 > 192.168.253.16.12345: sctp
1) [COOKIE ECHO]
00:06:37.693841 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 56: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 36)
    192.168.253.16.12345 > fct.35341: sctp
1) [COOKIE ACK]
00:06:38.227178 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 1406: (tos 0x2,ECT(0), ttl 64, id 31722, offset 0, flags [none], proto SCTP (132), length 1392)
    fct.35341 > 192.168.253.16.12345: sctp
1) [DATA] (B) [TSN: 4033198976] [SID: 0] [SSEQ 0] [PPID SBc-AP] [Payload:
0x0000:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
0x0010:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
...
0x0520:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
0x0530:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA]
00:06:38.227194 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 718: (tos 0x2,ECT(0), ttl 64, id 31723, offset 0, flags [none], proto SCTP (132), length 704)
    fct.35341 > 192.168.253.16.12345: sctp
1) [DATA] (E) [TSN: 4033198977] [SID: 0] [SSEQ 0] [PPID SBc-AP] [Payload:
0x0000:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
0x0010:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
...
0x0270:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
0x0280:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA]
00:06:38.227307 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 64: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 48)
    192.168.253.16.12345 > fct.35341: sctp
1) [SACK] [cum ack 4033198976] [a_rwnd 1047232] [#gap acks 0] [#dup tsns 0]
00:06:38.429054 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 64: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 48)
    192.168.253.16.12345 > fct.35341: sctp
1) [SACK] [cum ack 4033198977] [a_rwnd 1048576] [#gap acks 0] [#dup tsns 0]
00:06:39.301336 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 54: (tos 0x2,ECT(0), ttl 64, id 31758, offset 0, flags [none], proto SCTP (132), length 40)
    fct.35341 > 192.168.253.16.12345: sctp
1) [SHUTDOWN]
00:06:39.301463 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 56: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 36)
    192.168.253.16.12345 > fct.35341: sctp
1) [SHUTDOWN ACK]
00:06:39.301602 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 50: (tos 0x2,ECT(0), ttl 64, id 31759, offset 0, flags [none], proto SCTP (132), length 36)
    fct.35341 > 192.168.253.16.12345: sctp
1) [SHUTDOWN COMPLETE]
^C
11 packets captured
11 packets received by filter
0 packets dropped by kernel

behavior post 69fec325a64383667b8a35df5d48d6ce52fb2782:

Same as above IP packet got 2 chunks boundled to be offloaded by kernel:

2004-01-01T00:31:37.478791+00:00 fct [debug]   kernel: [ 1920.446450] sctp: sctp_packet_transmit: packet:0000000092f0f056
2004-01-01T00:31:37.478797+00:00 fct [debug]   kernel: [ 1920.446460] sctp: *** Chunk:00000000bdbc0d5e[DATA] TSN 0x5927a1ff, length:1360, chunk->skb->len:1360, rtt_in_progress:1
2004-01-01T00:31:37.478804+00:00 fct [debug]   kernel: [ 1920.446466] sctp: *** Chunk:0000000003d69060[DATA] TSN 0x5927a200, length:672, chunk->skb->len:672, rtt_in_progress:0
2004-01-01T00:31:37.478811+00:00 fct [debug]   kernel: [ 1920.446483] sctp: ***sctp_transmit_packet*** skb->len:2044

Frame is not offloaded:

root@fct:~ >tcpdump -i rio0m3 sctp -vvNep
tcpdump: listening on rio0m3, link-type EN10MB (Ethernet), capture size 262144 bytes
00:31:36.755633 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 82: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 68)
    fct.56496 > 192.168.253.16.12345: sctp
1) [INIT] [init tag: 2640168972] [rwnd: 1048576] [OS: 10] [MIS: 65535] [init TSN: 1495769599]
00:31:36.755852 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 312: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 292)
    192.168.253.16.12345 > fct.56496: sctp
1) [INIT ACK] [init tag: 321187571] [rwnd: 1048576] [OS: 10] [MIS: 10] [init TSN: 4058089694]
00:31:36.757278 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 278: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 264)
    fct.56496 > 192.168.253.16.12345: sctp
1) [COOKIE ECHO]
00:31:36.757418 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 56: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 36)
    192.168.253.16.12345 > fct.56496: sctp
1) [COOKIE ACK]
00:31:37.477246 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 2078: (tos 0x2,ECT(0), ttl 64, id 47270, offset 0, flags [none], proto SCTP (132), length 2064)
    fct.56496 > 192.168.253.16.12345: sctp
1) [DATA] (B) [TSN: 1495769599] [SID: 0] [SSEQ 0] [PPID SBc-AP] [Payload:
0x0000:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
0x0010:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
...
0x0520:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
0x0530:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA]
2) [DATA] (E) [TSN: 1495769600] [SID: 0] [SSEQ 0] [PPID SBc-AP] [Payload:
0x0000:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
0x0010:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
...
0x0270:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA
0x0280:  4141 4141 4141 4141 4141 4141 4141 4141  AAAAAAAAAAAAAAAA]
00:31:37.477368 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 64: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 48)
    192.168.253.16.12345 > fct.56496: sctp
1) [SACK] [cum ack 1495769600] [a_rwnd 1046576] [#gap acks 0] [#dup tsns 0]
00:31:38.630397 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 54: (tos 0x2,ECT(0), ttl 64, id 47554, offset 0, flags [none], proto SCTP (132), length 40)
    fct.56496 > 192.168.253.16.12345: sctp
1) [SHUTDOWN]
00:31:38.630537 0e:00:00:03:10:11 (oui Unknown) > 0e:00:00:03:20:11 (oui Unknown), ethertype IPv4 (0x0800), length 56: (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 36)
    192.168.253.16.12345 > fct.56496: sctp
1) [SHUTDOWN ACK]
00:31:38.630682 0e:00:00:03:20:11 (oui Unknown) > 0e:00:00:03:10:11 (oui Unknown), ethertype IPv4 (0x0800), length 50: (tos 0x2,ECT(0), ttl 64, id 47555, offset 0, flags [none], proto SCTP (132), length 36)
    fct.56496 > 192.168.253.16.12345: sctp
1) [SHUTDOWN COMPLETE]

9 packets captured
9 packets received by filter
0 packets dropped by kernel

5. Summary:
Kernel's decision of skb offload is based on
skb_shinfo(head)->gso_size (GSO_BY_FRAGS) which is not set correctly after
overwriting of transport->pathmtu. As the result internal SCTP gso variable
is not set correctly, so subsequent skb configuration is not applied:

        if (gso) {
                memset(head->cb, 0, max(sizeof(struct inet_skb_parm),
                                        sizeof(struct inet6_skb_parm)));
                skb_shinfo(head)->gso_segs = pkt_count;
                skb_shinfo(head)->gso_size = GSO_BY_FRAGS;

This causes required offload not to be performed and behavior of kernel is
changed.

6. We need to fix this because:
    1. such change of behavior (overwrite of transport->pathmtu)
    is violating user configuration.
    2. after passing not offloaded frame from sender to router, router need
    to perform fragmentation to pass it to the receiver or frame might
    be dropped.

7. Proposed change is to make transport->pathmtu update dependent on spp_flags.
If SPP_PMTUD_DISABLE for transport is set then return true, when checking
transport->pathmtu (sctp_transport_pmtu_check()).

Jacek Szafraniec (1):
  sctp: do not update t->pathmtu when PMTUD is disabled

 include/net/sctp/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.10.2

