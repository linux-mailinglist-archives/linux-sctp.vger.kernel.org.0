Return-Path: <linux-sctp+bounces-1255-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5f/UCx5gK2qp8QMAu9opvQ
	(envelope-from <linux-sctp+bounces-1255-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Jun 2026 03:25:50 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 554776761CD
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Jun 2026 03:25:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1255-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1255-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 130FB30B2974
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Jun 2026 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9182DF13B;
	Fri, 12 Jun 2026 01:25:47 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D809156C6A;
	Fri, 12 Jun 2026 01:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227547; cv=none; b=l4EkmM3KyaelX0ItmHEXCIZSb0pfv/oJSwm3LE+Im8oPIXOgqvxEik0rkN9A60v4L1+erFjQG5JKYUJk2Vdu9bkjH++Qi+a+sv2Fl4SbMmIQqR2J/WCjSnzh+Wurl7vV0EiLPE6kfDYhehQZ34P3jaFDIo89updgP74rjwQEUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227547; c=relaxed/simple;
	bh=alKnvACIKzCCoeHPjD16t1heXUmtzyHSAtiWeM7D2OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaKVEmdTJ88tZzdW0vkMAIK+Opoh0xxs55YlWwesIhBBBe1x1a0ljn9mupWwelggPe5DJQMdNpZLLxAb48DcOqmOIRAL6Y3RZ4V4oA7YVpbMQtOyBSRvszHA0TNhRtqX0KwCJoJZO7il8uhmwxgybFbhKwyc/cyMnqOGvAp9a0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowABHntENYCtqtTQlEw--.5250S2;
	Fri, 12 Jun 2026 09:25:35 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] sctp: auth: fix inconsistent key release in sctp_auth_set_key error path
Date: Fri, 12 Jun 2026 09:25:30 +0800
Message-ID: <20260612012530.7889-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHntENYCtqtTQlEw--.5250S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JFW7WF1kGr43ZFy3Jw43ZFb_yoW8JF1Dpa
	15Zr4S9ryxGr4IqFykuw4xZa4F9ws7X345GF40vF13A3s8Jry0yry8uFW0grW7ArWkCFWU
	Zr1jg3W3ZF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoQA2orLjJ1qwAAsc
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,linux-sctp@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1255-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 554776761CD

When sctp_auth_create_key() fails in sctp_auth_set_key(), the newly
allocated shared key was freed via kfree() instead of the proper
refcount-aware helper sctp_auth_shkey_release(). While both are
functionally equivalent in this specific error path (cur_key->key is
NULL, refcnt is 1, and the key is not yet shared), using kfree()
bypasses the refcount abstraction and creates a latent bug if the
code is later reordered (e.g. cur_key->key set before the allocation
check). All other error and success paths in this function correctly
use sctp_auth_shkey_release().

Cc: stable@vger.kernel.org
Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/sctp/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index be9782760f50..84708f87392f 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -753,7 +753,7 @@ int sctp_auth_set_key(struct sctp_endpoint *ep,
 	/* Create a new key data based on the info passed in */
 	key = sctp_auth_create_key(auth_key->sca_keylength, GFP_KERNEL);
 	if (!key) {
-		kfree(cur_key);
+		sctp_auth_shkey_release(cur_key);
 		return -ENOMEM;
 	}
 
-- 
2.50.1 (Apple Git-155)


