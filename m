Return-Path: <linux-sctp+bounces-1341-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RCPNK2lPVmrX3AAAu9opvQ
	(envelope-from <linux-sctp+bounces-1341-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 17:02:01 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A733756317
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 17:02:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=igAt+EmB;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1341-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1341-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 817A7303A26E
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D88E49218E;
	Tue, 14 Jul 2026 14:56:24 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4448C8D4
	for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2026 14:56:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040984; cv=pass; b=SFHmnqASjt2Y/SlJYhU4oqSnhWFNVqsXsqD1S5YWFMxB4ix3G4MpME3RKHY/NyKQRH+EQdg5F8xGyqB0RbEhjfaK36m4Uk+ISgjnityIHg267CLGIVylgcYwylsYazL3RhOJ/8grIASOSnihCzCh1f1onhZIIHc0zGNHq4WKEh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040984; c=relaxed/simple;
	bh=CXwQwHmNvO4bUr6Zlm4SdHrmJvOS/Lcja4aSUAKuQBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGElDlshWhD0IjtGTk330RxtClLeonZxS6lwbb642OCcoh5ntMtd3AI3+z0flujZ2rMAwOER6jVMc4dZDAIsSd4+D1dZ8ZISxM2ulXKrL22vdfK0caYffCKzKui3eqyr5Dso7owaR0bJYokbxTbgBVy9d19T4PMjpFyZjndN7pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igAt+EmB; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848d21bbaffso3414845b3a.0
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2026 07:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784040982; cv=none;
        d=google.com; s=arc-20260327;
        b=DTNa0q5S4MYAPWYVJazySkHspY878SfmInVwXNINihpp2ftrBARS5LDBvBP8CjsfAH
         p8xhowlDxXdbTJ3WP/Tpw5ylKgTb/BfdqqJKVe+zCGLPxJLJDyMPtS+7nKQF1uhKmxYX
         AgjQMy4fyiExded7YRx6ZR3ZapeFaBiy/TLOJFUKC4oU268xB7sPGTzxTit/ZZgSfM+X
         CVwt0ZyBfPBbGkkAF/UzXtWTwCuUaCjlYUihYtWOxPGi6QjNRY49vBpXge8OrOnYoclg
         5hII31JOyuyc5Zh0uA9kK63X1cHIVmv38e0kEupOlaXbOO6HAQz+ySb1K1WRuTPoNSJl
         kZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITepx6DjdIxnpEY9Y9KwBEdseYgD6B2WB1LGMQmvPJE=;
        fh=Lncqy00VisXOsFWIztWZ7uQUwx5IUQKD/rla90LE5c0=;
        b=URsJoyP2cMWtF6eskdnxULG/8dMBC8IjG383ih8OPnsp+HUPwyNQFctjUyzbYSk+aw
         NhbgxW3X/dEzavDGum3ouvGVsjt98m7B4XmD0Ry1y1mz0NF0eKKA8QEdLyep3FxvAMlf
         lurEP+RoW2m6WT9iWyzgkGYmihOeuBngNIGhPa4wBtQBPWAYsBVUjYwM62vI1UQwO1gz
         8vfAFCRasw35J8QQ6TxQsl7rozC15CXj9AaXzC1g1nrWVbEVtHiaUcrd261b8msdph5G
         hixwebOYk0i93/SphLTlpzTys+Lr8AuZnQG7Tni3fHWGtaNNdQXnNZ2EkChoBLOc+FNJ
         DoVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040982; x=1784645782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITepx6DjdIxnpEY9Y9KwBEdseYgD6B2WB1LGMQmvPJE=;
        b=igAt+EmBwXUGowYjv+kja4LpjB6eqdDqBPDFpEPntkKO5clYAMHH24DL6kQHhCwTZ4
         SaCqLXtvPj/ZSOgIBvk2kfyRCJr/UDu5nUABo2J5iAFFklU0wY2llcBD38pPN1pbfvfW
         7JTfICjhJhU270e8lYl+KLnrDnUWC2ncKV60xwrIR+/cfyH7LJeA56cDUAnqFppf90a4
         VZeyRiRIc3y8GmP/LPbzUy+S8Kfc/qnVKbtTjTGscJcN0f/z3ddW5kvp6QW2EsT1fOlc
         LqvX5DD3jdUNFHVuBfGVLhyWJWBvrm+tcJvkq1qIpfdENPe3ifX4eWrU8d19DIqxRT/I
         27zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040982; x=1784645782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITepx6DjdIxnpEY9Y9KwBEdseYgD6B2WB1LGMQmvPJE=;
        b=L6+FgH1wlfTvY+/3XzxVK4PrmEcAwi6nVPr5mvDXafYKmHtL2xwPs+qAvuhGBoBsFn
         VcCzbKHFMV4/FhFSzryDatUJxtOf03mqhnim8/ZxAMQN2L3y9MdoZd1nOPSGskZGiKsa
         +RJEMmQHpf53OIY1+C/ldPnrQ7ZYGRpG7h+XzV3KPWm8HgwSgRiuFA4nP44RsNCRdMkE
         czmKqHQ1KdGYMDhai+p9zniJ2Xd+rogsz948X77GHsCo3QURVaGnYruhyHNVIrFn95IK
         gnCm1+Xwb/pjMb0yWFXKxZgPC9Pkca+udPzSoAJMckc5X7AB+dx5/dbqzmIeUGkMdEza
         0Nkg==
X-Forwarded-Encrypted: i=1; AHgh+RrbipHb4/BoHne+Db8BGvytrBYal9tH/WeqGy0GLqqADgR0XPHyISck9e45hwpFoAeFV3SSi/twgLrH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AlX3ZkP5esw82QRh+rqJGOuH8VE4yfz2wPQuHWNAbm1W1QZh
	hiUHf56aZiOOPiC3rmnAOP4LXUz0uuel9tL+u4x9SWIGAkcGEaxznEG2g6ebLhodMxEg9dVEXYl
	S2CV0x29kBdIXJJfK684pFTjwHLAuDW4=
X-Gm-Gg: AfdE7cn/Xw8EsTIyrEZotQjI5uVMUMyXWcKb7gIiEkqYG9t/9mNvPj+koNhqWCR5fbh
	hfzQJPO1r+mBSGqr1kOvY9OYWASyMP4xc44vLbXuPWF9F4WDwAaFrkrblq7Ldj2l3krGXy4xkRZ
	+c1CuiDdh1Y2r3kNzvyIRS5mGaOo9v5M+sJ3TJUP+lKN8rxC/02byU6gYiiuelcPlkhdAJzzuU7
	VA7tjrRlG3aoCV2ddE5kw1SUqKE/csQCyY8mnohmFO1qpkI3DdMp2VcSJruk/YWMsqq8/bTRiOk
	m1lsPQAvDLhy4FXMX0ByGTABZxFmFVDSSnwFo4/NsgbR40DC4OF2NZ3pwqZ5iQjXQDjhdIT5LyY
	42Gp57+TVm49oEsN3qrX/792PrYnWqexPhiWhgJLm
X-Received: by 2002:a05:6a00:23cb:b0:848:2d1d:836f with SMTP id
 d2e1a72fcca58-84a557ee081mr2754412b3a.28.1784040982449; Tue, 14 Jul 2026
 07:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713032021.3491702-1-zhoujian.zja@antgroup.com>
In-Reply-To: <20260713032021.3491702-1-zhoujian.zja@antgroup.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 14 Jul 2026 10:56:10 -0400
X-Gm-Features: AUfX_myh9bJTdUyfEAcHraxX4Ij4RG8Ln7B_AWwpKCELo1Fds9HOrTWa6ax32CI
Message-ID: <CADvbK_d9mPZSvTiGCBJ_qHqbGo+z5BNEEc3wnvPkTFQCxO=MYg@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid
To: =?UTF-8?B?5a+S5rOJ?= <eilaimemedsnaimel@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1341-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eilaimemedsnaimel@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A733756317

On Sun, Jul 12, 2026 at 11:21=E2=80=AFPM =E5=AF=92=E6=B3=89 <eilaimemedsnai=
mel@gmail.com> wrote:
>
> From: HanQuan <eilaimemedsnaimel@gmail.com>
>
> sctp_auth_ep_add_chunkid() uses SCTP_NUM_CHUNK_TYPES (20) as the
> capacity limit for ep->auth_chunk_list, allowing it to hold up to
> 20 chunk entries (param_hdr.length up to 24). However, the copy
> destination asoc->c.auth_chunks in struct sctp_cookie is only
> SCTP_AUTH_MAX_CHUNKS (16) entries (20 bytes). When more than 16
> chunks are added, sctp_association_init() memcpy overflows the
> destination by up to 4 bytes.
>
> Fix by using SCTP_AUTH_MAX_CHUNKS as the capacity limit, matching
> the destination capacity.
>
> Fixes: 1f485649f529 ("[SCTP]: Implement SCTP-AUTH internals")
> Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>
> ---
>  net/sctp/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/auth.c b/net/sctp/auth.c
> index be9782760f50..c901d373af80 100644
> --- a/net/sctp/auth.c
> +++ b/net/sctp/auth.c
> @@ -672,7 +672,7 @@ int sctp_auth_ep_add_chunkid(struct sctp_endpoint *ep=
, __u8 chunk_id)
>         /* Check if we can add this chunk to the array */
>         param_len =3D ntohs(p->param_hdr.length);
>         nchunks =3D param_len - sizeof(struct sctp_paramhdr);
> -       if (nchunks =3D=3D SCTP_NUM_CHUNK_TYPES)
> +       if (nchunks =3D=3D SCTP_AUTH_MAX_CHUNKS)
>                 return -EINVAL;
>
>         p->chunks[nchunks] =3D chunk_id;
> --
> 2.43.0
>
Acked-by: Xin Long <lucien.xin@gmail.com>

