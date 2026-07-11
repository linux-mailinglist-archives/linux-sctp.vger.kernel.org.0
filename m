Return-Path: <linux-sctp+bounces-1324-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XBLIMznFUWpAIgMAu9opvQ
	(envelope-from <linux-sctp+bounces-1324-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 11 Jul 2026 06:23:21 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4546F7404D6
	for <lists+linux-sctp@lfdr.de>; Sat, 11 Jul 2026 06:23:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1324-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1324-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3BEB3035F3F
	for <lists+linux-sctp@lfdr.de>; Sat, 11 Jul 2026 04:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234572D23A4;
	Sat, 11 Jul 2026 04:23:06 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4E21CC5A;
	Sat, 11 Jul 2026 04:23:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743786; cv=none; b=cQLr9Eq9pSEQa8YqdyH0Bz0axDwcb4teDMD52GjmmSzJVFoY77xeKBa6Wj47MJktCcFv6EAfYTV+UTiwiokMxvwPrARdh+CJWp+CNRUxpW6LMnly3obqpuqURq5X10WzarACp9v9RaSV3VrPP+BlBvsfacpH2/CmFIUdGm/S5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743786; c=relaxed/simple;
	bh=Gouxmcm5kuouDRujJhN/PPdbtWpMwyVbeTWCP8xYus4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/bw4x9hlyipvR/G4hjdfbFkNXBSrlHX71L/l+ehHYkdmpTcXNQ4tS/rc9XJjeyaztoZEhd13iTDOtHpzwkwiRrpyWF3uajq9WWyv4FO2KMAT4i2eTep0k8xt/niSAnqoHkspKd3YwwHU7PL/9ye1gXLdXcLQ0rWY3XHwIBMug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Received: from enjou-Legion-Y7000P-2019 (unknown [123.114.53.210])
	by app3 (Coremail) with SMTP id ywmowADX5vkMxVFqVnZFAA--.44345S4;
	Sat, 11 Jul 2026 12:22:47 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	matttbe@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	tpluszz77@gmail.com,
	roxy520tt@gmail.com,
	n05ec@lzu.edu.cn,
	sashiko-bot@kernel.org
Subject: [PATCH net v2 2/2] sctp: close UDP tunnel sockets during netns teardown
Date: Sat, 11 Jul 2026 12:22:17 +0800
Message-ID: <c4eed94096ce6b4f1c9ff1f7f6b59f8de33e8e31.1782745545.git.roxy520tt@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782745545.git.roxy520tt@gmail.com>
References: <cover.1782745545.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowADX5vkMxVFqVnZFAA--.44345S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7CFWkGrykCF4kKr15urg_yoW8XF4rpF
	1fGayftFW8J34vqrn3GF48Kr1rCan5G39rCwn8Gw1rArsxGry5Ka40qrW8uF48CFW0kFWa
	vF1vgr1DKan8AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1s
	IEY20_GrWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRW9a9UUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAFCWpQq1gLqAAAsn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1324-lists,linux-sctp=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:matttbe@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:tpluszz77@gmail.com,m:roxy520tt@gmail.com,m:n05ec@lzu.edu.cn,m:sashiko-bot@kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lzu.edu.cn:from_mime,lzu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4546F7404D6

From: Zhiling Zou <roxy520tt@gmail.com>

proc_sctp_do_udp_port() starts per-net SCTP UDP tunneling sockets when
net.sctp.udp_port is set, and stops/restarts them when the sysctl value
changes. The netns exit path does not stop these sockets, so a namespace
can be torn down while its SCTP UDP tunnel sockets are still installed.

Close the UDP tunnel sockets from sctp_ctrlsock_exit() after unregistering
the per-net sysctl table. This prevents new sysctl writes from racing in
while the sockets are being released, and closes the sockets before the
control socket is destroyed.

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt%40gmail.com
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/sctp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index f5fe6ddf0d7d..5dbc7e9e8f06 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1458,6 +1458,7 @@ static int __net_init sctp_ctrlsock_init(struct net *net)
 static void __net_exit sctp_ctrlsock_exit(struct net *net)
 {
 	sctp_sysctl_net_unregister(net);
+	sctp_udp_sock_stop(net);
 
 	/* Free the control endpoint.  */
 	inet_ctl_sock_destroy(net->sctp.ctl_sock);
-- 
2.43.0


