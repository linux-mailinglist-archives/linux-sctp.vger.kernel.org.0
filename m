Return-Path: <linux-sctp+bounces-376-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E0BA5D4B5
	for <lists+linux-sctp@lfdr.de>; Wed, 12 Mar 2025 04:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA7B189954F
	for <lists+linux-sctp@lfdr.de>; Wed, 12 Mar 2025 03:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37817C210;
	Wed, 12 Mar 2025 03:22:37 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C67208A7;
	Wed, 12 Mar 2025 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741749757; cv=none; b=ZZ6sF1H/RW5mo9i8sKafiMYddQOWKTE8+DiQAZZ6FVN0LWeiQh1As4V/DAgQiJEiWmqtq7lXu7qEFg07kJmvSt2TDjeyRh9ndu8KWNoQFaPek2Junl1vH2VfaDJFbv5YvRnxiomUkVcOl3JD8zrr3PVmDEiW6H9AsfO5IMUCC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741749757; c=relaxed/simple;
	bh=TbXH7Y9Ntg+37ovkSqV+ypWVa1EdQELoePjgBPAgeu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gaUQh1mUFxJV50HgB39wBIPHFBtuamir2j48+P0SHxOUXE/JgIufWlDKUE1WLMn3E3MG7GSY0A8C8GaxKNy0aFomp8pIgip1it5+zvEGu80/bkf6w+qZ0BYt7usgbEZcS8tyszIrOlu/JhBOVZePMz0m6D6l3HyTtuDDmR/z11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowABHT1fb_dBnwcZuFA--.29647S2;
	Wed, 12 Mar 2025 11:22:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
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
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] sctp: handle error of sctp_sf_heartbeat() in sctp_sf_do_asconf()
Date: Wed, 12 Mar 2025 11:21:46 +0800
Message-ID: <20250312032146.674-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHT1fb_dBnwcZuFA--.29647S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry3tryDGw1kZF1DWFyrCrg_yoWkKwc_tw
	429F4UWrW7tFWrCFW7Gw1ru34kK3ySka4UZrZFga9rJ3WUJrWkXrykXFn8Cw4rC3WrZr1k
	twn8GryrKw17AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgTA2fQiJyojwABsR

In sctp_sf_do_asconf(), SCTP_DISPOSITION_NOMEM error code returned
from sctp_sf_heartbeat() represent a failure of sent HEARTBEAT. The
return value of sctp_sf_heartbeat() needs to be checked and propagates
to caller function.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/sctp/sm_statefuns.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index a0524ba8d787..89100546670a 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -3973,8 +3973,10 @@ enum sctp_disposition sctp_sf_do_asconf(struct net *net,
 	asconf_ack->dest = chunk->source;
 	sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(asconf_ack));
 	if (asoc->new_transport) {
-		sctp_sf_heartbeat(ep, asoc, type, asoc->new_transport, commands);
-		((struct sctp_association *)asoc)->new_transport = NULL;
+		if (SCTP_DISPOSITION_NOMEM == sctp_sf_heartbeat(ep, asoc, type, asoc->new_transport, commands)) {
+			((struct sctp_association *)asoc)->new_transport = NULL;
+			return SCTP_DISPOSITION_NOMEM;
+		}
 	}
 
 	return SCTP_DISPOSITION_CONSUME;
-- 
2.42.0.windows.2


