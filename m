Return-Path: <linux-sctp+bounces-1192-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIqtKah15WnIkAEAu9opvQ
	(envelope-from <linux-sctp+bounces-1192-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 20 Apr 2026 02:39:04 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E407B425EFF
	for <lists+linux-sctp@lfdr.de>; Mon, 20 Apr 2026 02:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3E42301C58E
	for <lists+linux-sctp@lfdr.de>; Mon, 20 Apr 2026 00:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C121ADC7;
	Mon, 20 Apr 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC2OQ2bE"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3C199D8
	for <linux-sctp@vger.kernel.org>; Mon, 20 Apr 2026 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645526; cv=pass; b=gNOw8E3KIXRahv0YBan+rVJrqU/a37OJ+dpnf635EjZ9J14wDKqnDXafmCE79WVuRuNQI5X38JTC6zmdv1IHwpP+xPiNqLpYKnPFaalecHZLQzMNDd8lr/WU/FjF/h0T3SxZCM60Tp5sfibkGIZ3Zb5GUZfd4tCs9nJHObKIERc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645526; c=relaxed/simple;
	bh=V+Xc+gnGUSlatwR6xO+m6P3xuojSJkvgpNiZT2dRtjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jW3sFelzNWJWe64kSy4/mJmFXcK7ZmcroNYOMiJoJAdTl9mkA7YnaiyF0ZppLRFlP2zm2dMCrQ4hscvItEgoVOFbh3vkHW/GLjp1TnALgtVNqTyudPGHYZFNW5CmyzaUmNYc5SewXNzgk3KGioMgBLZbBUqC8ZEzepr/aWTlKY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC2OQ2bE; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c565dd3a7so1134774c88.1
        for <linux-sctp@vger.kernel.org>; Sun, 19 Apr 2026 17:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776645523; cv=none;
        d=google.com; s=arc-20240605;
        b=gE3UmelMfhve+tL+EqKxyvFklX+05kAVaefuN2QLZpHIZr4kiynV9Jpaaic4cDvFZS
         H9czxXZ3qgLSE9JWs6PNUCujR4Mn+2SEOQ54cZlWpTArIxhQAJtyJIMYxMTXDpeRCU50
         0jqCRdsIL+3xRZdWZCFAbwz6AqTwM6Khc48dgpK8n/TpvlXOT4d0F63KDbJF8iH0d3pA
         yTZEjHQfYsTia0F9rz4k9c7F9NYeL0RTEdJ3RxQgiVj9YIAEbEPmgKgXAo1op45br9My
         H9GyG/1zgETW3jzIgKv54xgWuPNJ3VGCnshRSeB2OXTsslGQhDXw1fRUUtIu45VHiQ8N
         szow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v2+NAjo9ccDDaJAJPnPpHZkJNF/Ek3gXxSOX8+9kURU=;
        fh=CwByzF+hyibwbrahVD/MTf4ZvXATOaBAI/G7bPTtdLY=;
        b=InNIi32P2IynlxC1QO7tEakVJFWgIeufIeUJ/gNw1Td+2USWlTWX+iZbfg9h9iOVjC
         NYof7+32uVQgdCDz9G2btb8u1hj6MJTB5DgnDngbJkKTGAAuYkud7N7NUxqJXZMGzvSA
         RhmGqQvklA+vnfczNywlzl1Z2pH9pWruAQtuJyQsi+tinOvbvnqNxvP52DUgG1kM9WH3
         OyhXzDbf55/MmNge8b0OH7B/KyUneUYT0l5VqegPCzq8NJb9L+PVFyG35hB/ABitHPce
         X+zpyqvH+jxaCRZInC0Upxvo1I9ki51TZn2J0qM1/gGzfh29+fyKMtd9Q1LIkrMYH7iC
         zpmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776645523; x=1777250323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2+NAjo9ccDDaJAJPnPpHZkJNF/Ek3gXxSOX8+9kURU=;
        b=SC2OQ2bEKiP7e2J5gJMlNDxFxyArBRoEylARrBKCbgT658MNvj6rjA375HmYDgyNOs
         4qa97ve1+We6RT/G6SF9aWmoS5UBVqxCuVJepopr34Um/Q/FkjRgDXm8Vt9neMc76TPY
         mzaT1XNdgZaJSPZKuksdDEymoblulTfcl/9ZH3t2RV+uifN4mhh5TL8OiDDbDwIccTii
         a2If691rDoxTjS1UfVCOUZFBnVSuNHpVJVC4fGmVg1a7PjJyojiZptkidgWEQgx4VK8t
         KpcNbWqeNSES5qPEd3D63lVctqI4JHdlhj/1DwhGrDNJet0qqLvbqOEYkahQqT8cBFuV
         ZMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776645523; x=1777250323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v2+NAjo9ccDDaJAJPnPpHZkJNF/Ek3gXxSOX8+9kURU=;
        b=a49pC8qdcS8GKa2t6bOzAqGeeoi9CIOeYWwL3FIr3ZNmu2sdX6HcdEsI8CtkxKc5+/
         nq68aT0ZaX/fJsd/oLibUM46sqI01PL56EkWIQsJhHtg6c+zKytdc41w7Lw1n3HZV0bV
         +zVif9tb182CodqZcz32j9U9PYDTb0SCDLB+9SLBgG5ayT0EQuTOVNdONsmTfsJ4T2l2
         d2MpE7kYNqdqd8MQZg6/JpIjp+2BC3FxRN2B3xmSJOmtes13o7xZgpNEDgh/iT4tgopj
         e4SonWg7Bl4c82XACShGU8vWUI2rIQcNPzynja+iudoYCr4S/8PV2qhPTo1owz6AwQMh
         e6iA==
X-Forwarded-Encrypted: i=1; AFNElJ83fR2cdruKdtLcemZ/l2VvVr5AGe/65q37rRAg/ku66bvMYUeP/MGskCFleCgihGvX339LwqXFpxni@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9ZwVQOAd0Z/HXzHRPw5I2JypANffUm02aRuUHo9GJrfHiUhK
	UovLVs/cI7t5kSR4gD6aDkHN3x0MthN48rEmoDhEXxd/Urg9f9sgEzDcLV2BuBQha33m1LVI8SK
	+Mu5eiCo2frNu+zpQtdokU5IAOaN/XJZHhFYgw9Ev
X-Gm-Gg: AeBDieu62mVEenImCRtqMpZo8Ck9rgExvPzaSrpZZZrHG/WrcJxFzq3hCIDxNcGqTZL
	BrEx4HgKC+guQRlZQaiixJ1tWa6eyk8Ydm0CdckuXkMBVqsf7nt05/y1bIKoiJnYFEKQ16q8qN7
	iSJZhCnkiYjG14zcFI/6JtRFDDeSRIxvsF6cYde8DNKoMVzff2RazsEQXE5F+PxUJKF7pRDBFWj
	q4ODcM9D3t5dguKihbPwhbZ0SR+hrkNPNjqCxS4RI5HVKzXM40hI3vMO8nx/1WGEB1yOQCBsefa
	meyAPqyWSyywwpd+3Q6X/YlRA2XakrRMmeyg0SGdISDTGs/wQg5xTRAn7OKACFiRZLWM7lKqPBQ
	hXobskHNEXLVTaZILX7qyFpD7/7vSHkEfE3mmgqjlkrjgnYUPh0fZXQl8sPi/f8eBlUZnsEotCQ
	==
X-Received: by 2002:a05:7022:69a2:b0:128:cedb:33ba with SMTP id
 a92af1059eb24-12c73f70ebfmr5674965c88.10.1776645522913; Sun, 19 Apr 2026
 17:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com>
In-Reply-To: <af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 19 Apr 2026 17:38:30 -0700
X-Gm-Features: AQROBzDHytxBlqwozveGT6CDT-CRYyJYH_xWO4Xuf0Xb-n75HwRhJREtNelKaEw
Message-ID: <CAAVpQUCdXJS_VNNjtq_oiygaMJiFMoaJ2kynRR+aEu=-3aahqQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix sockets_allocated imbalance after sk_clone()
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1192-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E407B425EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 2:09=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> sk_clone() increments sockets_allocated and sets the socket refcount to 2=
.
> SCTP performs additional accounting in sctp_clone_sock(), so the clone-ti=
me
> increment must be undone to avoid double counting.
>
> Note we cannot simply remove the SCTP-side increment, because the SCTP
> destroy path in sctp_destroy_sock() only decrements sockets_allocated whe=
n
> sp->ep is set, which may not be true for all failure paths in
> sctp_clone_sock().
>
> Fixes: 16942cf4d3e3 ("sctp: Use sk_clone() in sctp_accept().")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Thanks for the fix.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

I fixed a similar one in 622e8838a298.  We may want to
perform inc/dec regardless of sp->ep and simplify the code
once net-next opens.

