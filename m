Return-Path: <linux-sctp+bounces-1209-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGqFGcMABWrxRAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1209-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 14 May 2026 00:52:51 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAEB53BA81
	for <lists+linux-sctp@lfdr.de>; Thu, 14 May 2026 00:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5DC301187E
	for <lists+linux-sctp@lfdr.de>; Wed, 13 May 2026 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF537DE85;
	Wed, 13 May 2026 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mobilearts-com.20251104.gappssmtp.com header.i=@mobilearts-com.20251104.gappssmtp.com header.b="WEi85vXo"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E62D29C8
	for <linux-sctp@vger.kernel.org>; Wed, 13 May 2026 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712768; cv=pass; b=IVHA35jpSLHc03wG7z5ouhf9JdOCF4HOVb+1jaa786UrJSjFyHAfOpB0xD6Q2Mjc7pP4PGbXJv2C9UAAApxiv5o8BdJZg4v3tcHVa4ZCwnolr95dQJ0cmY5VZfKuuvykWYfz/zvujVN1QOcYHAAEe4HBi3JDBW03fgh8ZbeYw2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712768; c=relaxed/simple;
	bh=1Si85Ifg5Ist8ONozvj3pFIgXDg6I17mq/UORTieXqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaiqQTlcC2xdUKNmp97h4TIm8d8ZymiLF0y3FisT2ZIHGwiJsKPKgZ8d+GNjzrtyeSDbQ3CXmr74AQj2o9lbYPIeg/GdA4Sac+okKsRebljez2wMwmBsdsydy4D6ICvhausUGoAP9mNyoj2WJPFH69QA3wyjvHJ7HBFtqJFcM8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mobilearts.com; spf=pass smtp.mailfrom=mobilearts.com; dkim=pass (2048-bit key) header.d=mobilearts-com.20251104.gappssmtp.com header.i=@mobilearts-com.20251104.gappssmtp.com header.b=WEi85vXo; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mobilearts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobilearts.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso7295936e87.1
        for <linux-sctp@vger.kernel.org>; Wed, 13 May 2026 15:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778712764; cv=none;
        d=google.com; s=arc-20240605;
        b=K62Bz1Hbam7kjPZuOqDV61jAqDDz9JVkenYSrXZL5xWEh/aY1YDXrUFq/CnJ9dN4Rn
         V7iHJSyCsmIxTZeIKtpIEtwSlb4CrzQdwhj7I0+bJMIvJ6vBUGf7mlB1bLtRuSJrKhBD
         YGU3RwobFzQU6yWTQISXOtSHbWwq+DnES/LOCavJHW7MggR4aNH62hN40G7nctUIBBhc
         XbCh11h37R8izpY9HZAHg6LoOLd9C6lPNd1rY11DzMFTisAlzqQAe/4Quz3yp+ZiYLbB
         Q4+hgYxzUgzL3WjIj3vlrQrIcpEGEZXJ2yKoLjVHFTpCDHf9WBZ4Ty9WlTOpUq7ly368
         zKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R8W2ARHFmrIEq//DPR+btZKXexiyoR04S6RD1uL7rX8=;
        fh=ScB7dW++h5CEgcb+ulqwPbBHdHD9JPvfnOGioLmRA9s=;
        b=ifzeHfq3fpUOU/nV4BOiZt7XtiNT0VmayWQ959tGFpaa6cpd3/QQ4oM4yXOOuFDF+q
         ciHHKj/kL/vfpCao5c/ZaKAacV10dSTfyZeLo3z1+SBHmDlg0k8DaoAvlgxavFB1qtZE
         hnIvLtF2hlS9Yv4q68BlCT0yQRvClWZSriosg3ajQtrzc929XijjdLtcwPUjNmpWyesd
         EDVrumDaE3Vbz5gfir3Hq0LyyjpCSPDedJs1UQAr4dPZ315eS7I+PPjiyVCfJDHnlHz2
         qu6NofG/CzUaWJ27QrLcIBb2WuqFnYfOABUWaN1R433DWHwoTYlyazQVSD28m9HVGsT6
         w58Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobilearts-com.20251104.gappssmtp.com; s=20251104; t=1778712764; x=1779317564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R8W2ARHFmrIEq//DPR+btZKXexiyoR04S6RD1uL7rX8=;
        b=WEi85vXoaVFT+/Z+PUSLGVp2SvQFrt+daUio/wqa20YhfnC6z07picikQzzKJ5IOHF
         u0gY4YEY5EodrBh+3hUCiPbpuWeniEsg/3b6dUfyW6yKyrpEui/xLKZ3kUQdeETGDZeJ
         Vl28ZE8qryilFnlD73t0NqB4gzPPo/9B83JXLjdNL9nTKK9Ns3jM4C0eLi0jNZDNrSul
         Z+0gLhQbYZ8+kjaGh1fc+c//adhU2noDqVIS/08EDM71JGc/jp1TFrR/OUC43giQ768Z
         tkXVLxa4PzG2tR/eD6wFRKv9lnkz2C69DSi7/8euk14AWpYFt1A3z7uGePwY/9HKBOKB
         6vMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712764; x=1779317564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8W2ARHFmrIEq//DPR+btZKXexiyoR04S6RD1uL7rX8=;
        b=F3IW7P6aASB1Pe+G8jJFBUvIZTbq7HN1T3uMcWbnbDOGI+dU7EB2xRsOZKcjDhKCN3
         2u09vzf8wTWvKz4UOaUoidLuqSA0+IKSA6YBZXcXeWKw8MrZJvvhJhW6DBiceNhwbf18
         13OOKS84FyoS+/UiNoyfpeAf0Wr5MzNVBa6ygQCSy27ynA7lpKmaZj3DJ2Als/+iktRa
         WnO2l5lhq+TcaQTqtLXEWlMyhR+zz1BNAYdkVJQgziSkFTKe7ysFBhqFAIkhu9h1jS0v
         a4txhL5sUbFZ0GJ1meIiMFAwYo06mpOvdobEyvFMq1ZkVPCJUtPiVHzqRw8HiH4UXEJF
         +oRg==
X-Gm-Message-State: AOJu0YyYSHkZPqshN4qu4NuTPvOO/2ta5bBiYzzhoAR10yuvOSkHHS2Z
	Ig9Eaz+hDOV4OyBYhGju5zoja+S2pEP5UGKKPszR72f6aOVJ3O3THKPxchM/Xr2z0IC2svPl1S6
	jvGDDAYDjYwgSbv0xUarsJYGCCi8bDwLVcm8FabLDcZ5x+ctULjbEMU0=
X-Gm-Gg: Acq92OGbKUpPTeI0jv/fdVlER6C/p41ahhCxuCQRuv4pQo7wanlHlbfo/bDwUyVlfJk
	2Kp10oEDiiv0qg5fJJuBM0HqEgjyUwNtDkJhk8gfvFlGoxME52HssuIziWpn6H9uz0aeZlZBB26
	MttEZi4ZS+/m+ShnO+Aenc8gwLV3KuhgP9TkOPKoB8dJlSrj5c7Yz/6Uf2smyjR/Ui7TOmROx8d
	VRNx4Ti0MfhUKOWzxOz7NOzdLpfl55qVxE60UEIKIV3VbiPp4Cokzgb/e+88c60hN0q4VBI+EY8
	05SYKw==
X-Received: by 2002:a05:6512:159f:b0:5a8:53c4:f8b7 with SMTP id
 2adb3069b0e04-5a8ef99711fmr1735271e87.27.1778712764476; Wed, 13 May 2026
 15:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200302093532.GE43827@nataraja> <YYhAp8jG0dvxi5bU@nataraja>
In-Reply-To: <YYhAp8jG0dvxi5bU@nataraja>
From: Jonas Falkevik <jonas.falkevik@mobilearts.com>
Date: Thu, 14 May 2026 00:52:33 +0200
X-Gm-Features: AVHnY4Ix51AyR9knkgFNNiiSx_erumQ9nTvOTrnazv5MragrSmJWYcxl9yBRzWI
Message-ID: <CAPvfYfBLLEwWnoYVfm8vCMtQEvhDhQ0yGGKjdzOhAeVG3nP+eQ@mail.gmail.com>
Subject: Re: SCTP <= 500 pps unless SCTP_NODELAY set (was: Expected SCTP DATA
 chunk per second performance)
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AAAEB53BA81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mobilearts-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mobilearts.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1209-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonas.falkevik@mobilearts.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[mobilearts-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,virtme-ng:email,mobilearts-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

> Unfortuantely it seems that the problems I reported in March 2020 on kernel 5.4.19
> still persist at least up to 5.10.46

I ran into this problem as well when doing some testing.
And the problem still exists as far as I can tell.
After looking into the details it seems to be related to pathmtu and
sndbuf size.
Since the messages sent out are quite small, the overhead for bundling
the outgoing data eats up the sndbuf before hitting the pathmtu size boundary.

This makes the send block with only 1 packet in flight,
which is not acked by the remote side until SACK Delay or number of packets
set with SACK freq, usually set to 2.
Sender is blocked by sndbuf and can't fill the Nagle bundle buffer
for the second packet to go out.

Verified send is blocked in sctp_wait_for_sndbuf by:
Small change to make the function traceable.

 /* Helper function to wait for space in the sndbuf.  */
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+static noinline int sctp_wait_for_sndbuf(struct sctp_association *asoc,
                                struct sctp_transport *transport,
                                long *timeo_p, size_t msg_len)

root@virtme-ng:/home/jonas/tmp# bpftrace -e
'kprobe:sctp_wait_for_sndbuf { @callstack[kstack] = count();}'
Attaching 1 probe...
^C

@callstack[
    sctp_wait_for_sndbuf+1
    sctp_sendmsg_to_asoc+362
    sctp_sendmsg+1619
    ____sys_sendmsg+376
    ___sys_sendmsg+153
    __sys_sendmsg+136
    do_syscall_64+270
    entry_SYSCALL_64_after_hwframe+119
]: 47


Then made a small change where the max size for bundling is
min(pathmtu, SCTP_DEFAULT_MAXSEGMENT).
Would such a patch be of interest?
Or add a max data chunk counter to cap on?

$ ./client -n 1000000
About to send 1000000 chunks of each 150 bytes
1000000 DATA chunks of 150 bytes each in  0.95 seconds: 1051674.12
DATA chunks per second

The problem only manifests itself when sending data where you can fill
the sndbuf before hitting pathmtu size.
Bumping the sndbuf to to approx 5,6x pathmtu should work as well.

-Jonas

