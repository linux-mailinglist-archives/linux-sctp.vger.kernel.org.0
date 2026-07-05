Return-Path: <linux-sctp+bounces-1308-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pVLpCdmsSmqFFwEAu9opvQ
	(envelope-from <linux-sctp+bounces-1308-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 05 Jul 2026 21:13:29 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF070AE26
	for <lists+linux-sctp@lfdr.de>; Sun, 05 Jul 2026 21:13:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lKNqQ7lj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1308-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1308-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98DD5301C5BA
	for <lists+linux-sctp@lfdr.de>; Sun,  5 Jul 2026 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C1A27FD51;
	Sun,  5 Jul 2026 19:12:24 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9217369D67
	for <linux-sctp@vger.kernel.org>; Sun,  5 Jul 2026 19:12:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278744; cv=pass; b=J5u0frS/Z3qKPh51a23ZuUfowXV/JJzQd+6F4NPq3Vqp1Z/uJuqW2MLP4xE96/F8xr9IHeLfS+6y94IRrm74u1OdSDXCH49Y2PsG9gszodh/Pat/WPtWpe1xQB7COsmEecV1M1GackNc9c3acyivZpP5lcEBla/s5+Tul/94SyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278744; c=relaxed/simple;
	bh=kzBIwScZkxmJaAbRIZn89+TPiZbPYudZb4JFa930OGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM6QsdKUoflmFRm4QB45kdSIdyVTwnGhSgrnntF6MtcQ7i4ssutQ94zABdYzk4J1xTp9SWfTrzieDPGAm4wc3u/e0d9IzHnzfygGMFL415RcbhQ6QJE+AR8YsHFGOvPMoYHjqTsQ+BheTmm4spQjyTanP8hdeGlBaEUHgQ+C3vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKNqQ7lj; arc=pass smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-847968ca62fso2293112b3a.2
        for <linux-sctp@vger.kernel.org>; Sun, 05 Jul 2026 12:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783278742; cv=none;
        d=google.com; s=arc-20260327;
        b=cI+Y0en8cMzY+u4/QZFTdFyT9GMH9iMWFmrhlMAQIMdVCn6qLRQs6qM4J8evUJNc3C
         /U39aeCoAOEq8zZPyx6/sOknJ86DnAvfmfhwx4YE4zk14V1A3vTYU0rMx4SerrXrbL/m
         YFwAB+GHJtaalonGwHalQHpZRDN0lGW6YAfftjEE9RGv/oQD3vtPhBXl3ll9lFln+hKs
         3EDYsmrm9t6vInexiDOysQq3LMI5VUPNNAGLTtJsOTRQWl01Kk5wSOWQ0bSABIy4njjU
         Pm/MdAsFIHM1kLROH/upRdTMsMF5zWMQNVCPcyUsAWF/orDe8bk6tt+DEulOt6AQPvd9
         w2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        fh=Enj6pdyevHm1NFzZ3CjWYMp8VzNSOsnt5cye7bg4EzA=;
        b=bYlYyVC0p0V6Njzol2L/EoT9hB4BAG4XtQnqVnCEvfizmarkI9JlT3hUCF9hkMEBWW
         B64R+fXW34IaqzoW2v+6W5MHwpxMT4u0YteciOUfjwuNH5GLS8EDY9yaRisGvRQr7FPv
         kPjzn8nTdCdEeD9bVpxGO+Q4M1hzY8qFVzbDm81meIlnvRea2tFWJuIQH6EENImbLQ5H
         tQRPtDVsWBoSQR+jmYO+XPcF+UlOZVa++gHlPeQLGIqu2Bqxxoc3ygccmFedCJWBpmLX
         9Htwksd7MbmjiXPBTvW/lYvWSj+868zViIo6aWXtg83Yq3jGfoMtol/pEbnI3KXvP9Rk
         rcog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278742; x=1783883542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        b=lKNqQ7ljm0Q2s+uh5ZBmKjNi6BfodIrdl24723FeBhzQvFumO+GY0kVFGYH8mMU1ra
         Y4rR0pmxeLK7qjOinA+wYWkM9Z9u5d+1eEfve5Vnvc3qLc5doWdrqLCeUJxhO/9uwHbB
         puNO3wiY6Nf+IXn+0jYXlRoCaqL/zeNI8dv9mPelgESkhGkuH58N0mXDjRSIb8p2jaOB
         XMusjDqZnGCHeMbkWdLjm8lVVQKFYW0lFTvvrOYoDrxIkXkEHd+kYpT+WoEuFEm8+9NZ
         2xcjdGDNHa+RpUjrm2WYGdvahUBdCI8k6gNSBahham6UsAE7uHtEbS0ot4k9clpeK6X5
         KQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278742; x=1783883542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        b=IgXlm9PWD0LnDl1r6mqyJG439LorVt6yfFtd9yjJ4Qvcr7HDkKOT7fQlRNUt2Ni3t8
         e6rySUU6EoB5yppY67jZpbYK/j60rh5hSzp5kD0Zw/6sP44+bNkILmta2hEy7f4qk1Bw
         kPWSZKpnx7rIc6PYJpXrmlJ+9EnDerkXW+Mo6hT8NJkukWaYBTD7BiVT8/Sv9mgY19KF
         uoc/Zj8iWWHfpEqOUbMPpuCXIOHQfb9q+9W9lzB3mxmlvwHsfszMQ/2Ssjo9NfaKLehM
         ty9BfyNHtCHNOqxO9Z/765iCNgzqwD/Ui2CCkl60feoI29YzF97JmpJH37U3vVTILBvC
         avjw==
X-Gm-Message-State: AOJu0YwlcdDRcplG2CJ9nsBc0FfhGXyTZaXYx+cKTchOcGMLv4Gq1e0d
	LQBIHEh9oGgRcvfRtSW9rhaih2PFsjfM2yDeNDT9SczZT58ksTlUZqQEmPKVRfMmWyTXJ3NW3Qo
	g3zRrRPTaB96zGRWGcFLquuSFghxnFO4=
X-Gm-Gg: AfdE7cnDSPQs759mvLCu7o9Kd6jE8xXjs4Je1p0it4TazR0uxjaztnBD8saq2YLSc66
	nkHU9M9uRkduAYk+r2Ezx9TfEanDPH/Y8lnJrgP0bvRJGpIAp+cUwart4+I/u9cVXGWOAtawfAw
	PgSlIjPdZN8S80o/wDMwPYDiywkppJujXkfGzULZX6Dj1LamShdFT/wQisqwQQNXAw1mkJTnlBN
	pQuEpqb6Wm7Pdfg6WiH6pI10yHXxYPkTTHS47dU0tVDTrNygyWtwCpY2E2HUtCLnfvNPOrdRyCb
	rVbb8nur2j+3UzqRAOQmIOZ5aVFRf2gN9gUW/pUw0EztJsIgermCTSCsuU5ud5aYgta9UpC2JQ=
	=
X-Received: by 2002:a05:6a00:4b4b:b0:847:77e7:6f6b with SMTP id
 d2e1a72fcca58-847f6f96baemr6642867b3a.59.1783278741837; Sun, 05 Jul 2026
 12:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704033545.2438373-2-bestswngs@gmail.com>
In-Reply-To: <20260704033545.2438373-2-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 5 Jul 2026 15:12:10 -0400
X-Gm-Features: AVVi8CfHA-j0EDc3OlrYh1r7n_r_L9jvhfkZenL3RS3ltcoq4Bgp2Uu1c7Bg_Sw
Message-ID: <CADvbK_eJ+qePAuDF0u=rmQ2brixwmxhJRrUHi=jnbWoh169OfQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate STALE_COOKIE cause length before
 reading staleness
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1308-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:linux-sctp@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:xmei5@asu.edu,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,asu.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EFF070AE26

On Fri, Jul 3, 2026 at 11:35=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> When an ERROR chunk with a STALE_COOKIE cause is received in the
> COOKIE_ECHOED state, sctp_sf_do_5_2_6_stale() reads the 4-byte Measure
> of Staleness that follows the cause header:
>
>         err   =3D (struct sctp_errhdr *)(chunk->skb->data);
>         stale =3D ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));
>
> err is the first cause in the chunk, not the STALE_COOKIE cause that
> caused the dispatch, and nothing guarantees the staleness field is
> present. sctp_walk_errors() only requires a cause to be as long as the
> 4-byte header, so for a STALE_COOKIE cause of length 4 the read runs
> past the cause, and for a minimal ERROR chunk past skb->tail. The value
> is echoed to the peer in the Cookie Preservative of the reply INIT,
> leaking uninitialized memory.
>
> sctp_sf_cookie_echoed_err() already walks to the STALE_COOKIE cause, so
> check its length there and pass it to sctp_sf_do_5_2_6_stale(), which
> reads that cause instead of the first one. A STALE_COOKIE cause too
> short to hold the staleness field is discarded.
>
> The read is reachable by any peer that can drive an association into
> COOKIE_ECHOED, including an unprivileged process using a raw SCTP socket
> in a user and network namespace.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Cc: stable@vger.kernel.org
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

