Return-Path: <linux-sctp+bounces-275-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9B19B5145
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 18:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE7628213D
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2921D2B28;
	Tue, 29 Oct 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUmht5d5"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE54192589;
	Tue, 29 Oct 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223985; cv=none; b=Ia5r9t0GVfCKJHFI9abdFEuogWwc7VRtRmYNT+Xce/P7x21xt6wNgchHdt3KY3FWqnwLqibo+DiPesJ477oFyIxeaL0FZ1DlTdB8mLIsPIynPg9y4iuQiP7RaeFx52PIrpuPK/BCkFgdoZrFSCHiJwuGMqTV5iKDQWDqrDS7A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223985; c=relaxed/simple;
	bh=R7trcbfArRuPy5MCLW/VxV8JzRUNecwkntxMoDb0i30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4oaStPcg0yAUcrvUAmU2o50lUQ/YYm4vT4pQar5Wn8DJxxH/DxMov0VzN/lQJid0KWYn2a3BSlCUuIiMt4a1jeiO0IQtAo4vhftYfHVakQN8bs4MecW97d8+64gG2GnBjdic/1KipHQVOLvM3vVnihX+uWofrTZ62ubogXVq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUmht5d5; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso28271116d6.1;
        Tue, 29 Oct 2024 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730223982; x=1730828782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0Fvm44WesuRZGxBh/x6Fxq8sMFr4yLcHaDCmXukXME=;
        b=JUmht5d5bsKWcOtrqlRd8djphGoLZrQAaojfBd892dgjl7si5xcknjS6CTkjNckJHG
         QLkIoVt9ftBh5nf53m1L8L25Y2jO0VHU1btS8nti+XQD6j7Mp0dzsivDUp2s1mVwKIg/
         m6yYzqjBtD7Tr+gn96DKRxWp2QfGgK3XS7BLkfazwtOZztY1ygPujsY2UOnUz4VEL+OI
         NDzM8LutCv6RkLk0M8JUSWYNeb5yTqpvY9F2NR9BLw/qb+aHcbDG2vRbfn0gLNR45+tm
         cICKK0rTfAoyxlpokGilb5UIDueTus5qMyd3rc9TgNSKyXXN+EtdSXPSHUTxMxNx/RKP
         q6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730223982; x=1730828782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0Fvm44WesuRZGxBh/x6Fxq8sMFr4yLcHaDCmXukXME=;
        b=Emfcb5KWIqSgRvoiT+XmfydF6M7/alw4B2Uj4/5ecR91SsOQRLRBipdZ+j/aCaGtL+
         nctUlwNnw5L3NIgiHCsjEoEd7BWIai9dlmA2uzAL/Iiv06fMwWS3VvyMkW7SH2/NktRw
         jRJ00pgWUCbSO9IM7zAHuBLAnfbd5HB7vfdI3I84TWI7lq8bRg7+p7yMaedujPFrWk+C
         4oXE/UdSJJIKxxAIsKpbJA5sgI5UI8lCVHS7pPBPokDs5csT0Et9BIx86XTQxd/qVU8W
         weL3BjpZoBRIrcrZb/TA1hcBWq9JSRcsGgtjKILqycW/75hgTuwZJ0mqu2C9DI5lIeDx
         W1iA==
X-Forwarded-Encrypted: i=1; AJvYcCUT+XwlAsr7t66jw+a8ga+K3rEQWvW90bMvhHK/1YNVRLpwiIAefZeaJuyXDa8qrEexePPFrQY58UsF@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVqv+7ehxBRs272grZe4B195E83ykLG2nHgx6YvfbgKXW84pG
	LmmHl1BfJWrWL71VHoKBHD4rCJDGsi7gJzYVgVURAe5yW31ZPelHOLifWA==
X-Google-Smtp-Source: AGHT+IETudjIYwsjMzeCzW2jBIpSZ1wEMT60ec949/fqPCGdmRIGDNd6Wr914SSWJaUtzVjX90G9xQ==
X-Received: by 2002:a05:6214:3d11:b0:6cb:f6de:3d11 with SMTP id 6a1803df08f44-6d18584fcfbmr207737236d6.41.1730223982544;
        Tue, 29 Oct 2024 10:46:22 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f68bsm44133626d6.15.2024.10.29.10.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:46:22 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: properly validate chunk size in sctp_sf_ootb()
Date: Tue, 29 Oct 2024 13:46:21 -0400
Message-ID: <a29ebb6d8b9f8affd0f9abb296faafafe10c17d8.1730223981.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A size validation fix similar to that in Commit 50619dbf8db7 ("sctp: add
size validation when walking chunks") is also required in sctp_sf_ootb()
to address a crash reported by syzbot:

  BUG: KMSAN: uninit-value in sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
  sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
  sctp_do_sm+0x181/0x93d0 net/sctp/sm_sideeffect.c:1166
  sctp_endpoint_bh_rcv+0xc38/0xf90 net/sctp/endpointola.c:407
  sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
  sctp_rcv+0x3831/0x3b20 net/sctp/input.c:243
  sctp4_rcv+0x42/0x50 net/sctp/protocol.c:1159
  ip_protocol_deliver_rcu+0xb51/0x13d0 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233

Reported-by: syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_statefuns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 7d315a18612b..a0524ba8d787 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -3751,7 +3751,7 @@ enum sctp_disposition sctp_sf_ootb(struct net *net,
 		}
 
 		ch = (struct sctp_chunkhdr *)ch_end;
-	} while (ch_end < skb_tail_pointer(skb));
+	} while (ch_end + sizeof(*ch) < skb_tail_pointer(skb));
 
 	if (ootb_shut_ack)
 		return sctp_sf_shut_8_4_5(net, ep, asoc, type, arg, commands);
-- 
2.43.0


