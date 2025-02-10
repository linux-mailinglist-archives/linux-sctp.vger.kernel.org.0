Return-Path: <linux-sctp+bounces-329-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3E3A2F564
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 18:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C5B3A2C88
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636CA255E4C;
	Mon, 10 Feb 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB2m38EC"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A5255E29;
	Mon, 10 Feb 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208956; cv=none; b=pAZFl3GV1Q7qOYZIYh4sp1GNizRYR3RmuZL+tSwi8bXmzwcUYqhXbl2I+gRt7apaMO9EywN5VKynzvOcDkgwBHC0YkS7S4eBzOF5+DsRoDrxOjq4PYauTSDjCLgqFMZPRUKyLhBCN2XpYpHbIbTl88G3p0s+Ww8a69H1MZNTn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208956; c=relaxed/simple;
	bh=K5rH8yZuWaHQsW/Hmh/BQZzH4I2VTPmTdZGyRtJopVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klK/zzEQt++cixewNtKZWR8e1ksrhK/TU7SeeKbMYmgP/D0W8vJBBNV6NFwHtDm3gHP3jNn+CeeoYRamZPvPtR09ElFyMuwtz2D7r4JyfsA/o+jLdJasi5zNOI0kRMhX4r2wBNGKtNnnv2aaYMC9YNoYhIPc++svX2OPP2jKzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB2m38EC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f49837d36so51885195ad.3;
        Mon, 10 Feb 2025 09:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739208954; x=1739813754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wIPh28JHeMdjxgoX7eNvcuyIuylq8PgSgc/+RQbaX34=;
        b=YB2m38EC0HOo1fOj0FHQFRaXQd7V1siyTo/FMvLwWZ6/e6f9O352dHoJEgs8FEM4xh
         PxygqFHqjQm0DgkfuXzAuQfPJlQxB9nowI5QFLr2KKwOpWoyB6kv249CQd2FlPA/Zq+O
         /fZDlg3P/1q4CUc5GF0oc3ry5pSYwtcwQ64DKzPJnQ1olm+UbhCtmQjs+LKiNejpNPhJ
         KwOhIinYn3r5hxYkenovCBxqz3yFiGCDFS3Kp0QZQWB3cWWkyNTYzjMjcoD7oMmOeLcl
         FwA2lank8e8u8Fy+gkoLEIFHZYLv+Nud+OBwz5FlVucPNRbUPH5dalAXBVIaDxCK8Lh6
         3xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208954; x=1739813754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIPh28JHeMdjxgoX7eNvcuyIuylq8PgSgc/+RQbaX34=;
        b=hS3fPKlyS36sLO9S4fNgaWuuGUOkpvjCVsZUwqnVg8FG9B41o/LvsSrzH8MMazojOg
         xRk482ucFk29LrfdM7wWUhsNt1xSR24CeZcDpUqQQhogYD2aB407HI9qmI2GpWWBY2QL
         Do+9sel1+UFq7woIiCJfP3Ktd76WFEgcFCs2ylJrYdGz+lA+0TcV/NcfcwCuYvLPgwGu
         DKL0WF0BmRO2W+fA/J0VvwIRYX6MrQFrHcWxHe6pOsr4FeqNKv/2vqShxMgeAWP3IQOO
         a8Ncd4Xl6qDefJD2jz6s6BPLy0JWoSe8FKdonUlYD+VkOOnefyW8DnNTSrtSnSBy7yyS
         VNRA==
X-Forwarded-Encrypted: i=1; AJvYcCUnNb/0xoZzSfvJBClopb1BQ9Szal5+2Hkp6SiaRQa94gFKFGgAYnX2cW9ZSdlbpWHdP90jaK2fES+7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mPoUzlGT17HvAJiDnboYk6t4BX8U6LbLQJhXTkcdA8nqtuLn
	kFt1bBi3pyfvKOQokXSPZ1plX0mxMpcG6/AueMXZpHfE55l6OaB8
X-Gm-Gg: ASbGncv3GQSbEQpqH0UQCtPOs6+qUkXLwj9xF+BeqD92pvayo1EWjzyHiCC0i6dl62p
	no2WXGb4fAz/7E5JI8dQ9AUsDDJmLYSKI38+BLUGiBqksBqkFHQv1CdRMzXxV+ilt6w4LQA0yjw
	wbjah4VCtd/JNpj4LKpCo2Dz30f/qf2z+44mxBTEtr9KyyTG0RbuUDq0b7USduyg5BbYCyvP873
	Je7EjMnrtf0WQtUGVfNbZB5eNzEhB9u+sO3KHPVoNw95FbHi3MPWXIjijGIT7Mi6w9Bgb5FZ6HY
	OLqqgB46GBf+oSFNv1rphS8fUULnEg==
X-Google-Smtp-Source: AGHT+IFOfk0K4Xmha4jU2LXttDjpbOZGHlg/iNfRWGEu8hu8nvUNEYQfysyNtympPeQ9HNBUfsbWkg==
X-Received: by 2002:a17:902:ce90:b0:216:2426:7666 with SMTP id d9443c01a7336-21f4e6b8854mr274373235ad.12.1739208953832;
        Mon, 10 Feb 2025 09:35:53 -0800 (PST)
Received: from t14s.localdomain ([177.37.172.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c79esm81752845ad.175.2025.02.10.09.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:35:53 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 3D808E70FBB; Mon, 10 Feb 2025 14:35:51 -0300 (-03)
Date: Mon, 10 Feb 2025 14:35:51 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
	thorsten.blum@linux.dev
Subject: Re: [PATCH net] MAINTAINERS: Add sctp headers to the general netdev
 entry
Message-ID: <Z6o49-Iv5kCdPwL8@t14s.localdomain>
References: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
 <CADvbK_dtrrU1w6DNyy_OxizNwx_Nv=mjs5xESR+mB8U6=LKXdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_dtrrU1w6DNyy_OxizNwx_Nv=mjs5xESR+mB8U6=LKXdA@mail.gmail.com>

On Mon, Feb 10, 2025 at 11:44:10AM -0500, Xin Long wrote:
> On Mon, Feb 10, 2025 at 8:25 AM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > All SCTP patches are picked up by netdev maintainers. Two headers were
> > missing to be listed there.
> >
> > Reported-by: Thorsten Blum <thorsten.blum@linux.dev>
> > Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 873aa2cce4d7fd5fd31613edbf3d99faaf7810bd..34ff998079d4c4843336936e47bd74c0e919012b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16509,6 +16509,7 @@ F:      include/linux/netdev*
> >  F:     include/linux/netlink.h
> >  F:     include/linux/netpoll.h
> >  F:     include/linux/rtnetlink.h
> > +F:     include/linux/sctp.h
> >  F:     include/linux/seq_file_net.h
> >  F:     include/linux/skbuff*
> >  F:     include/net/
> > @@ -16525,6 +16526,7 @@ F:      include/uapi/linux/netdev*
> >  F:     include/uapi/linux/netlink.h
> >  F:     include/uapi/linux/netlink_diag.h
> >  F:     include/uapi/linux/rtnetlink.h
> > +F:     include/uapi/linux/sctp.h
> >  F:     lib/net_utils.c
> >  F:     lib/random32.c
> >  F:     net/
> 
> Checking some other subcomponents like: MPTCP, TIPC, OPENVSWITCH,
> HANDSHAKE UPCALL ...
> 
> It seems that we should append:
> 
>   L:      netdev@vger.kernel.org
> 
> after:
> 
>   L:      linux-sctp@vger.kernel.org
> 
> in the section:
> 
>   SCTP PROTOCOL

You mean, "also" append, right? And not "instead". Because currently
the NET one includes all other files and it doesn't exclude stuff like
net/{mptcp,sctp}.

