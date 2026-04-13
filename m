Return-Path: <linux-sctp+bounces-1177-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OXaBn/j3GnBXwkAu9opvQ
	(envelope-from <linux-sctp+bounces-1177-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 14:37:19 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 894943EC0B1
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80F67300653A
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512143B8D6C;
	Mon, 13 Apr 2026 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V50yf/Uj"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837C352C29
	for <linux-sctp@vger.kernel.org>; Mon, 13 Apr 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083835; cv=none; b=PJ74kSUjX0Ki1UAfWLSbRC3B0VmJvpmVzEvKXQysoVAQXOhd5IF7vm7abQZyaSLoxsPKhF/tRC1sn1TCYcxDMpFB0wYD+B0dEp5SbzD8JWmQ0Q6wc48i2Yhy81V2E+qIEknu35C01ANoeTnGhWkmxof7ZtDFKn9HyI9ypX0+2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083835; c=relaxed/simple;
	bh=BtXUyGAJBLoGMjIfXC8nKb6psyTAKOaBKkJ8gJNx5fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyEUetRCJPnol4ysikyfOyz/bYf0gXPCptO4Ray8nMps45vtH5X1tcofoebj0qQRGSWMGFv2tDtpQhvKuawGyvX3dUzrr3gm0EPuIrBUpApSZJpgQoM7gopsZ79ge+yRQNheXSMGiEWVUB9JWhGqEY5kE5zuReK4p2mDMF3LBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V50yf/Uj; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1271195d2a7so5942471c88.0
        for <linux-sctp@vger.kernel.org>; Mon, 13 Apr 2026 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083833; x=1776688633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90bOo6XUZoGgDsOa3XWYgMG0p/UBMe//yktmShtDn1U=;
        b=V50yf/UjDCsIG1brK5C04PGTO78xFsGb74kD4BB0o0lOhaa5VnLs6NylegLU33ydKv
         AffLsxoUty8Ol1Fcc3Be4QrGbaf5Yzgo0/HcnfMpCTOYIbV+yvY8HM1iqnFeor81InlY
         Ik4vAXWDcvI050hkmOrT4Z/eKi3Tv9KNBXoZd1PkWJNTE1PWLNPGLWzxuuQsSOo0XSPX
         LVQEjy88sHBGUEFzRzemNXxalEeq4Ig84vgtAoZxRcckLfVjzBVtmBkYfWicyq1EqU/D
         Uvbjfg63Qmiu7UpUI31k78cRkqHYckSuXOzJMxoVFd02t6+uPfQyB21wrwnH8RROmq2p
         tQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083833; x=1776688633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90bOo6XUZoGgDsOa3XWYgMG0p/UBMe//yktmShtDn1U=;
        b=Z/FMVD14uouukvHsUHKObvMj3zRLmWcU4es22xQ/br8r76vU247QOYB1axJ8BNmMhN
         YJF4TyZ1xTva6KH3IgCJ4lcWbuTqBPZ1JjBeqBkKJnWnDWqi69mkQyYoUkbiyEXQ96NU
         xvQAJQ559/n/Ox9QIwISusKhPKXYcZj8l+gVah0a1aoOprkHuN9o8wv/sSddFbCr0wlo
         QBfK3UoS0vr707d4MHC9H/377nQq4gQmTnS0079fwpMgl1zHzDImHSZMzFB97q8D4aln
         ZgeKd2/UsCAijx0dyyosm8gS5mTzpWEK7ofyNUa+NkfUwKMXz1fD+MBvt9UbOHutHQNr
         PExg==
X-Forwarded-Encrypted: i=1; AFNElJ9A7IfG462yCGZy973SOwE9hdDUsruoowMhF/QMFQhNcYMS8wbJz/WiRUXinOOLHhMDYWyOEGbhnLbs@vger.kernel.org
X-Gm-Message-State: AOJu0YwJq/60hYSvWHG/oF/Sm1mxjWaAomTZBovCtxc7o3At1SV2ret/
	AkThm6ofeLHxvpTvrCseaD7pJQLZWe1lLfs4O9zuo5R8SeD7qDhoupMX
X-Gm-Gg: AeBDietrdyVO2AQDyFMUEbUU7gEsD0c1eKRZgXLR6qza5kA63tToKfxZbpeRahn3S8O
	h2S3lINWn/131Nvjm6WEmtpmaLLYkGyMMsswayLZnVQbK1sMSRAutxylUbecKDqXKSLBPCEFDa2
	jT2crpzabZ2XSMVFkjTitb5hfLg8+m7+fT6+7V6jcxDIPYxknnNRkUnfP4suZ0ZUk1WF110kYeh
	73JPud6f1+aFHFv+lsvwgvqzUC3clLave7KCgq3YptPlWVSUNZ6Jy2vfnYAOsYxlpf10XomErHv
	EpiE45Q0aZCiBeluBkXfvAKc44peq7kW96FadgKOnYlRfLK1QGaebB/rBvWq/m8Q0DalYbL0rDS
	7kuO7jClDLPPt1wZvPwZ3brRmUjKFCKRza+nv1SLkEZAV3Sw7/tKXavfHVECHO/zFYPxnOwGfUz
	3My6IT8iw7PERa3jO8QFYXtwWAPNcptNuX
X-Received: by 2002:a05:7022:ec2:b0:128:dbbf:fd35 with SMTP id a92af1059eb24-12c34f09a4cmr7189823c88.28.1776083833317;
        Mon, 13 Apr 2026 05:37:13 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537::3a0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm13109153c88.0.2026.04.13.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:37:12 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 1919113FAC08; Mon, 13 Apr 2026 09:37:10 -0300 (-03)
Date: Mon, 13 Apr 2026 09:37:10 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] sctp: fix missing encap_port propagation for GSO
 fragments
Message-ID: <adzjdjdll1fi5e6N@t14s.localdomain>
References: <ea65ed61b3598d8b4940f0170b9aa1762307e6c3.1776017631.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea65ed61b3598d8b4940f0170b9aa1762307e6c3.1776017631.git.lucien.xin@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1177-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marceloleitner@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t14s.localdomain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 894943EC0B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 02:13:51PM -0400, Xin Long wrote:
> encap_port in SCTP_INPUT_CB(skb) is used by sctp_vtag_verify() for
> SCTP-over-UDP processing. In the GSO case, it is only set on the head
> skb, while fragment skbs leave it 0.
> 
> This results in fragment skbs seeing encap_port == 0, breaking
> SCTP-over-UDP connections.
> 
> Fix it by propagating encap_port from the head skb cb when initializing
> fragment skbs in sctp_inq_pop().
> 
> Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

