Return-Path: <linux-sctp+bounces-1176-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBHNKFDj3GnBXwkAu9opvQ
	(envelope-from <linux-sctp+bounces-1176-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 14:36:32 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829E3EC0A2
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 14:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D232E30078AB
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90608361666;
	Mon, 13 Apr 2026 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMHYrx8z"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263A1A5B90
	for <linux-sctp@vger.kernel.org>; Mon, 13 Apr 2026 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083781; cv=none; b=bZ9/zYp09RZ+GG+RwGFxA0MV2tzBRKHRG4N93g2XfP5dwIn5G/jsw2ny60hihtjIR2J0Qs6zecyJjotfRV3nv7Ut3CPNNJmz4x3VltH2ddSTkInoJBir9nlf/59Cb6y/11uvJp7wFzbg3g08lmJdYI3+JXrPTof2tI8FVCQ4Mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083781; c=relaxed/simple;
	bh=duDBEuMQO+r39fUBlpMvZykm25SnTiIYgtpUPvcaeHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb9+cnqs5M6Jla04RM88tBAMH+g9EsGXZfeXv60Epjs1+kr9T8KqChWJYTzuSIdxPNbcoYusQ3DJr3JZQhxbK5WhHvj+g+8zvcBZjWrKs48G2HcZwtptcwsrv2LXYW9ZmHg/hZpOXxM5MXKQPyK6A31RvAKpxfW3Rrc9Hn+WFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMHYrx8z; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1273349c56bso5583357c88.0
        for <linux-sctp@vger.kernel.org>; Mon, 13 Apr 2026 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083779; x=1776688579; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SzjQnFnXmG73dA0+oAWDE1GrYR8ou6+5ae07pUlGoHQ=;
        b=KMHYrx8z1jkF81Yaty9MXX47Jny2GJguqfnhNz4s1p4k3MHwxz6CPbWmDrSmSAayBG
         pUs+XvgqqIcYpmSA/f+pVoOsv4YJrPkHxFislzvTl88s17fJT48LAHM+hfx3P8uO/yId
         6Vy+o2yB8UZiijFp7nwPsxzp05pdBIkRtgLWfLNhB7uheZzJIqq3PB0hWfMZVCPYaJhy
         E1KK3zeZNF2QboAlh0LJ+Jm0ucO44eUoxb9SnCq6W2ri0oSHW2ytnjE4EcR2S7yvFpTM
         2rdEfUwNTfeYYPORKcZD8SVUkyZcasftNa2JpIgO7nKSjd2TlcfGBUbmTPKsGsPcqfQZ
         Amdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083779; x=1776688579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzjQnFnXmG73dA0+oAWDE1GrYR8ou6+5ae07pUlGoHQ=;
        b=FS5N2b3MMbQSsv0ziRjGfx2u9SRb9G/MjbrbTLapYyengKvnPbM/6rq35rrOon4k4t
         cGpr1W/KdGW1dhDplMTxVjqNazHqh6CJoQ3WObM10HuE6j1ks/gAe9/tkOJNYwi1U8bw
         NkHhaBE7tK7OLiI1WkmX0Enep94Qt2KOBclT/3TtyJ14MB9Qrv9UIiXhOT66AAhyYX8q
         KiLm3j/n4OA3hG1Q3uvJwke44MfJ8iXCZ7OcecYbL7LeQfJcoV19HaREikuNjH0GuF9X
         BISFFwusRJGEs7/cPgYnYeaBJFVj7qNxjuzD3p648ar4/8v/UPbexywL8xGSUNTg/02z
         rVXw==
X-Forwarded-Encrypted: i=1; AFNElJ8D5wqB0r5SCalojD6HuZuJ+DtGPd0eDgxDLRD+aXeEo3r7vNn/6cs7Z37wni8q27CmsAZvAeogmPul@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7mb22FiqnZvGdFL0+Wi4uAMVtNydon8EhXKTK4yApl36QvNJ
	nkf3LJxGhuBrPmA/cVCpJP+Rik5mLF44BG/i/ViMxngLsn8VZQHp06bK
X-Gm-Gg: AeBDievwDRwQpmHqWH6BDQW6zJQs82SxW1+6VfORb97RjfmHMPoGiEtSDc9UIBvxJgQ
	Ao/Q2H9b8MTR1NcY8yb5YBGhK2L/FtrWsjmH28F0+APvmsjge0k9M0xuk8iXcNYm4umz2cLHzrr
	KQYn1ZcfDteO+fkD89765i3Xz9yybWoG94TVKQHQf66FjUXQCqxZIvbgLzKtD9jGLCGwNWhBLVb
	MlM7Hep0oCzScFat6vgbbZ4zTUFv3D62WShXUK1U4duJ2jFE9HobywsC7eMsXqE+jMY/ampyw0U
	DBCCsaxuN3k64gm60WuIdzSvM3j43293BpRyfjeYzYP99AF1vgVnQBpYQkQsYrzSGH3pZ0gfCRj
	jKKTJqRF0c/QRUO4WysZmz/LDkyY4CvmpgG1fh4tWQB96JM7sb0VUQjY/3ExlCYYUCFd6lRuE1K
	vJkTu54rIixV13hX1zu57b/A==
X-Received: by 2002:a05:7022:389:b0:12b:f8f0:80c7 with SMTP id a92af1059eb24-12c34eed8d6mr6361870c88.21.1776083779414;
        Mon, 13 Apr 2026 05:36:19 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537::3a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d940083f49sm3844288eec.13.2026.04.13.05.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:36:18 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 489BA13FAC04; Mon, 13 Apr 2026 09:36:16 -0300 (-03)
Date: Mon, 13 Apr 2026 09:36:16 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Yi Chen <yiche@redhat.com>
Subject: Re: [PATCH net 2/2] sctp: discard stale INIT after handshake
 completion
Message-ID: <adzjQEZ18m5taEzr@t14s.localdomain>
References: <cover.1775847557.git.lucien.xin@gmail.com>
 <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1176-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marceloleitner@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t14s.localdomain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1829E3EC0A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:59:17PM -0400, Xin Long wrote:
> After an association reaches ESTABLISHED, the peer’s init_tag is already
> known from the handshake. Any subsequent INIT with the same init_tag is
> not a valid restart, but a delayed or duplicate INIT.
> 
> Drop such INIT chunks in sctp_sf_do_unexpected_init() instead of
> processing them as new association attempts.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

