Return-Path: <linux-sctp+bounces-1198-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBAmLOwl7mn0qwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1198-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 16:49:16 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7550146A6E8
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 16:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDA6530058D7
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7AD369999;
	Sun, 26 Apr 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NenE3BRc"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9283367F3D
	for <linux-sctp@vger.kernel.org>; Sun, 26 Apr 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214942; cv=none; b=l+P9tuy9NPVSsb2/ugpw/ZeRBrIH3I+5mulQvtjVJAWepm/89rvsjPkKP/kK012wBYiweSgB8TzJjJfVvYbkc9ewtTCuMPUQXo33TaLtvBKeRontaTnrqtjiVajVjRzlksoMNHhGP3fFHafl4x1fV9fH/0+1vxSnduk4GqlHwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214942; c=relaxed/simple;
	bh=vsm/Vin6fhEHMK5Rg/gfXmdGW6NjOiPfcld3a7a7Zqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJnWuwQLrcF90zBPGcHXWcu2NoqPkFOZIKCynJPEWo9KfDzaeDm+fxYhVtLHnZVClqkvAXmX+KlrhSAjZHKuWmZX4OelO3U0sNtJd6mY9dc4rNgT8cEcPaBaHXAB6Nkh9DmUkdiytlo7PikI6CQzjSZvnm44nMd+9gri/KLTIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NenE3BRc; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acae26e564so113142686d6.2
        for <linux-sctp@vger.kernel.org>; Sun, 26 Apr 2026 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214941; x=1777819741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLYe3X7mIdfpi7a+4xLOp68gaR+hsDkG8LtdUaDQjF4=;
        b=NenE3BRcLW34Jayeyr81Rdt1Zunk2n3OcSKDbKUkSndZ0irM9vsWGeFB2cTG+SK39g
         f2ZRdW8UlOO/tGmmespooz6WOSBI1CBQoYWX6oLnkpqeEQDp3hcU3LwsU1RNTpd1nI7o
         /WNuy3zwMo751bQ3AJW7Ij0y8BrNIT0M+Js8Thf89EX03zHW3f0+CLdB9/yweyKi7m0g
         vcByteO/ISTpDr+pQcDLCovC6WC3LJBMdP8s0IgY2ic+pJg6DowPYqoL60Oyt4qSd3By
         1AiR1DnQuGNNmmHfmtw55B5QLnq8xQx3vMqTQBjEd7M3mn8C4pJsQ7bXphAUzPtcv88g
         rE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214941; x=1777819741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZLYe3X7mIdfpi7a+4xLOp68gaR+hsDkG8LtdUaDQjF4=;
        b=q1H7KCAWkLjhajNNo7pqoZr38R791tXy3ghxTGvJmpgUX48rdSIGF52+nMyUslyBAX
         kjsfyuxPzoS/N6AebQ0d+0QxnYUpL9UskaqxCpuSjg4MXL7sfefyUhRZU5HjGnrP71kX
         iwhLSonSdU5KDzMpHB4n6cfrmw1Qi7sWpf8S4h67RGlJEampzSNm8qDIXsvuJYqYPdPW
         bPUWQNK/MAYIU3p0G3U5z/2FCSBRgHz7+KSJs/asJR1NuaTr5PZ9zLA6kQC2+pxjBfeF
         zTR4YDTVeDKMx0V5IiqtQMdHylloa+Bu/Wsps6dNLSQvrCyO/WKUxCUZ72+oQMTPyX5w
         fsXw==
X-Forwarded-Encrypted: i=1; AFNElJ/f5IFKAtAbY84f0oX5N/wqq9D+cdv9Qy/yZit/pk5AKvF5nqhBc/jBysAti2gkorRkzYwLoEfga/5t@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlcoJ+5o43+c6Sgvghkwl3/zWJp/JhL25VsMAX+8I3e1rhlSt
	eowUYZyWuwsHifs8O42UiOWCHChBiP8tbwD9KP8oK8dD7ofrkeaq6dFY
X-Gm-Gg: AeBDietkZVRekSkL08Mh0sqCs57r4Dry1pJBlzoeCsEXmqJ1Ited/KVPo6PQPrwG2ll
	QwfOlew7/1n4oIyIQ8lcJjAAEf3dexULuQX580pJeSMayc1pKNnmhudholY79/bNqqOAmccEyX/
	1MRrsR6bN5Y43cMnhGzn1Rc2dAV1LfN5sqByRDm/jPdqG/MwefPTWx7Y9V8518rzWFxZUDB+vxS
	bwrKlv6ElJr3rDILXhhIdTy9dynScLslwnNPJG54HX7HKhLVD4ScrMpepJEPrnQpzG2pRblFFSH
	z65C1hLdlcydLDkeTzBULc5PTOo1qhOL3ttHBpKi/7K6sNMqvY+dxUzKkJQNqXlhfa1LeFb9+lY
	n3gJrw1BROJwY33/mKIWo0puG+Vm5g8qsZa0sHHHBL1R0Su5kVatXTp0nUfPcYHYecthV/fNsOV
	L4GFNgyo5xsRCGsHKd5MqxSd/7rrT3OmYyNLEPcTq/UFAApGeayoydkokt6IPLAh06VUEaLe0ff
	2JVYCfQWarnvUt+CGLyRHiQTLeX97aeBqTc33JmJ63MfVHdztyH/0uFT33668cak1kKZG/0dxY=
X-Received: by 2002:ad4:5bef:0:b0:8ac:ae21:46e with SMTP id 6a1803df08f44-8b03a1885ecmr509647676d6.31.1777214940620;
        Sun, 26 Apr 2026 07:49:00 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc655sm232579146d6.48.2026.04.26.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:48:59 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yi Chen <yiche.cy@gmail.com>
Subject: [PATCH net v2 2/2] sctp: discard stale INIT after handshake completion
Date: Sun, 26 Apr 2026 10:46:41 -0400
Message-ID: <5788c76c1ee122a3ed00189e88dcf9df1fba226c.1777214801.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1777214801.git.lucien.xin@gmail.com>
References: <cover.1777214801.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7550146A6E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1198-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,netfilter.org,strlen.de,nwl.cc,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

After an association reaches ESTABLISHED, the peer’s init_tag is already
known from the handshake. Any subsequent INIT with the same init_tag is
not a valid restart, but a delayed or duplicate INIT.

Drop such INIT chunks in sctp_sf_do_unexpected_init() instead of
processing them as new association attempts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
v2:
  - Fix INIT tag comparison by converting the on-wire init_tag to host byte
    order before comparing it with asoc->peer.i.init_tag.
---
 net/sctp/sm_statefuns.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 7b823d759141..8e89a870780c 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1556,6 +1556,12 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	/* Tag the variable length parameters.  */
 	chunk->param_hdr.v = skb_pull(chunk->skb, sizeof(struct sctp_inithdr));
 
+	if (asoc->state >= SCTP_STATE_ESTABLISHED) {
+		/* Discard INIT matching peer vtag after handshake completion (stale INIT). */
+		if (ntohl(chunk->subh.init_hdr->init_tag) == asoc->peer.i.init_tag)
+			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+	}
+
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
 	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
-- 
2.47.1


