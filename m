Return-Path: <linux-sctp+bounces-326-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C8A2ED5A
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 14:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C951887A54
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0114A629;
	Mon, 10 Feb 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eepKwnjS"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461717557;
	Mon, 10 Feb 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193397; cv=none; b=O4ss63OQAZG8AihnsOgOZotKQZp/knATEJjWKIqU4uz5MPlOpjJQsHsE63EGxvfOJ4kqDlVyPG6SFS/8e1UPCSxlcL5LaOcyE9PDB6958XWEqXxZVHDJAX9C8ymHGTU3A5DZFX8XY0T+6Vp7suz/2nUFZV+4GAALEIY3xCNgnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193397; c=relaxed/simple;
	bh=OaISnqh+JHx0ZIGX0rt9+0dmhjZZJJsLuxVxxDf4c9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbNa/iFnCpTSiUG0xfBPg6emAiYUAR55c1EHPfi8YJJjGx5D2i5G3ZmKH3Xi2mwuMLhGIS/vqLf+JzeRHDpU62YbjdNNhgPxbL83aWiqt+xoLsKB0N4WQSQ6CGjwR9dAPdaLVeyLZLcMcTsJOWoLHC5NsKtpvb/v9l6mZ5HlTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eepKwnjS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so77076305ad.0;
        Mon, 10 Feb 2025 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739193395; x=1739798195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovnjjAnAITJmHDgPxHcdLbhpXDkdc0FV6FbZoB0ygRA=;
        b=eepKwnjSI6JJN/6P2/BWLu5zgB4R8WTM5lxZvFTdDQuv1a8fY1Jb6gP6zOxOUHqi2O
         0LpEhVkZUnMyKh+aIV/iqKSEd1/n23FA6x4tnt963BjkKpUx0J7uRCYkPwjGH+scI//0
         b9u7zdsbFBxYUIUt2dNtbuZwhvwoSEM/wJaNVsTP/6zrHuDifOAVPbR3w+h2mFJzAQg6
         ofk/5H0RkXm/E0lXm4iBa/8mZ2Z52z4SgVweRddynZze7t71KdYbR5uaijsfAgxXy8XF
         MZKP0S0KNxT2pcT5JSBLknpVgxP2pCavAlqqiivRzMpy7Hs+v/M6wXuzdlc4FvBEgk4u
         F/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739193395; x=1739798195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovnjjAnAITJmHDgPxHcdLbhpXDkdc0FV6FbZoB0ygRA=;
        b=Nn1L19o+DBg4FY7Epn2oIPg+6UnEe7p1PEc/42YXF+D6TY7qr59uGO48rVse8CRG3r
         vgt17RA4pHksZZSbRg0Sz0sW66EXLRuS6jv8c5/VTc2TovEvvQXrHBUcRS4BwaRemN5v
         sTz8WmbB+syQnMC1wpEz2SGKU+spYkfkEM+5nzRn68ifrdtwP/9VXF1TeZIMwKv5QRPD
         0h8qpyrJLwcj5azGT+UCFxTBZWJgy+8wa30P0Kr7x2GLtIPmn5unvt1LgDkbfRSG2Yv+
         568JpxwjqmjyMrWZfHdmyPYhiOZnz/Sxz5ai7MRz65pGbgHebKL1Qyrb2f79ZQur0TVb
         ubnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM4jrZTw1pv31B68awid/SjHVY6H6aH1H9GF/OC7nidvRraC1sLrEyb/KxkQRBHTTyOrvmIiTMEcDelg==@vger.kernel.org, AJvYcCVSli2LKN7abuUnxt2KUeRG5Ea3TmHQC5/mHDzUQ0qdmmnrIifUa70zHDbtQfjO1pdi4FAlG9jduKXB6JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHttd/g3PNKG3PiMvJjcY3z9gNFewcbvaoNysJGqRjck4SseH9
	gnBQac+fmijkTruICALoUPfaY91RTyEKxnNkn1qGbUGNAwhVaQJ1
X-Gm-Gg: ASbGncscNlOpBZUhiTaKu/y/cAC7aPIh1w7bv+GLJ2AhOm+ZUPyV1SGKFa1KKOWStBm
	Plf5Ycpe6fedCanRGblwYp92A2rhnsTsvMvpvwJG0j91JNRF6Tv0WPpkQ3Kp4uz1VcHh0cLbD23
	isj0/bShOSMCl9tKhl/SrIL+4Ib6mHBdVN++58LTBUDTuMiiGuLMldDZ4xx35ZbS6++sjq0E61+
	bL13PzlvYfnkOYAlPnSfgefGTwNiaDZB/+l/rhDmVIGuNfLd2OHkoeA3k6ohYoyi+hIrBTCdKBV
	PtlwT5tZhDFIR7/pGHvMzAlkieAX/A==
X-Google-Smtp-Source: AGHT+IEfftBXT6Dxu784CnNuph8zRp+lXr8h+wXS+DDCNuoN71vp2FSiBmWLdnd465JgZmPsFuuvtQ==
X-Received: by 2002:a05:6a00:399c:b0:730:9424:ea3e with SMTP id d2e1a72fcca58-7309425213dmr4432524b3a.11.1739193393717;
        Mon, 10 Feb 2025 05:16:33 -0800 (PST)
Received: from t14s.localdomain ([177.37.172.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730889e0c5fsm2453875b3a.119.2025.02.10.05.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:16:33 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 00DE0E6F51C; Mon, 10 Feb 2025 10:16:30 -0300 (-03)
Date: Mon, 10 Feb 2025 10:16:30 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] sctp: Remove commented out code
Message-ID: <Z6n8LhxIIctmrbo8@t14s.localdomain>
References: <20250209210024.5413-2-thorsten.blum@linux.dev>
 <Z6n2ZOTs_fKx-w9z@t14s.localdomain>
 <71FF1CAE-ECE2-4E91-AF88-71F868E454CF@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71FF1CAE-ECE2-4E91-AF88-71F868E454CF@linux.dev>

On Mon, Feb 10, 2025 at 02:07:18PM +0100, Thorsten Blum wrote:
> On 10. Feb 2025, at 13:51, Marcelo Ricardo Leitner wrote:
> > On Sun, Feb 09, 2025 at 10:00:24PM +0100, Thorsten Blum wrote:
> >> Remove commented out code.
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > 
> > SCTP patches are picked up on the generic networking mailing list.
> > You need to send this patch towards netdev@vger.kernel.org.
> > Thanks for your patch, but please post it over there.
> 
> Hm, the get_maintainer script doesn't mention netdev@vger.kernel.org
> 
> $ ./scripts/get_maintainer.pl -f include/linux/sctp.h
> Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> (maintainer:SCTP PROTOCOL)
> Xin Long <lucien.xin@gmail.com> (maintainer:SCTP PROTOCOL)
> linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL)
> linux-kernel@vger.kernel.org (open list)
> 
> Should this be fixed?

Yes. I'll send a patch for it. I believe the changes below are what is
needed.

$ ./scripts/get_maintainer.pl -f include/linux/sctp.h
Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> (maintainer:SCTP PROTOCOL)
Xin Long <lucien.xin@gmail.com> (maintainer:SCTP PROTOCOL)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)

Thanks,
Marcelo

---8<---
diff --git a/MAINTAINERS b/MAINTAINERS
index 560a65b85297..eee8d442a4eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16182,6 +16182,7 @@ F:	include/linux/netdev*
 F:	include/linux/netlink.h
 F:	include/linux/netpoll.h
 F:	include/linux/rtnetlink.h
+F:	include/linux/sctp.h
 F:	include/linux/seq_file_net.h
 F:	include/linux/skbuff*
 F:	include/net/
@@ -16197,6 +16198,7 @@ F:	include/uapi/linux/netdev*
 F:	include/uapi/linux/netlink.h
 F:	include/uapi/linux/netlink_diag.h
 F:	include/uapi/linux/rtnetlink.h
+F:	include/uapi/linux/sctp.h
 F:	lib/net_utils.c
 F:	lib/random32.c
 F:	net/

